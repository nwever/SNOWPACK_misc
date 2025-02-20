// SPDX-License-Identifier: LGPL-3.0-or-later
#include <iostream>
#include <cstdlib>
#include <meteoio/MeteoIO.h>

using namespace mio;

int main(int argc, char* argv[]) {

	// Azimuth search increment
	double azi_incr = 10.;

 	// If a command line argument is provided, use this as the search increment
	if (argc > 1) {
		azi_incr = std::strtod(argv[1], nullptr);
		if (azi_incr < 0. || azi_incr > 360. ) {
			std::cerr << "Error: Increment must be a positive number between [0, 360)" << std::endl;
			return 1;
		}
	}

	// Read config
	Config cfg("io.ini");
	IOManager io(cfg);

	// Read DEM
	DEMObject dem;
	io.readDEM(dem);

	// Read projection information
	std::string coordin, coordinparam;
	IOUtils::getProjectionParameters(cfg, coordin, coordinparam);

	// Read the provided coordinates, remove duplicates and generate metadata
	std::vector<StationData> v_stations;
	const std::vector< std::pair<std::string, std::string> > vecStation( cfg.getValues("Vstation", "InputEditing") );
	
	for (size_t ii=0; ii<vecStation.size(); ii++) {
		if (vecStation[ii].first.find('_') != std::string::npos) continue; //so we skip the other vstations_xxx parameters

		//The coordinate specification is given as either: "easting northing epsg" or "lat lon"
		Coords curr_point(coordin, coordinparam, vecStation[ii].second);
		if (curr_point.isNodata()) continue;

		//extract vstation number, used to build the station name and station ID
		const std::string id_num( vecStation[ii].first.substr(std::string("Vstation").length()) );
		const bool has_id = cfg.keyExists("Vid"+id_num, "InputEditing");
		const std::string vir_id = (has_id)? cfg.get("Vid"+id_num, "InputEditing"): "VIR"+id_num;
		const bool has_name = cfg.keyExists("Vname"+id_num, "InputEditing");
		const std::string vir_name = (has_name)? cfg.get("Vname"+id_num, "InputEditing"): std::string("");

		for (double azi = 0.; azi < 360.; azi += azi_incr) {
			const double tan_alpha = DEMAlgorithms::getHorizon(dem, curr_point, azi);
			if (tan_alpha != IOUtils::nodata) {
				const double angle_deg = atan(tan_alpha)*Cst::to_deg;
				std::cout << vir_id << " " << azi << " " << angle_deg << std::endl;
			} else {
				std::cerr << "Cannot determine horizon for " << vir_id << ". It is likely not contained in the provided DEM." << std::endl;
			}
		}
	}
	return 0;
}
