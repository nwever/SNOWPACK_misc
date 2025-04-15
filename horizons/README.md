This tool can be used to generate a horizon file, to be used as `INFILE` in the MeteoIO [TauCLDGenerator](https://meteoio.slf.ch/doc-dev/html/classmio_1_1TauCLDGenerator.html) generator.

# Requirements
- [MeteoIO](https://meteoio.slf.ch) library

# Compile
To compile:
`make METEOIO_DIR=/path/to/meteoio/install/dir`

# Running the tool
1. Get an appropriate DEM that contains all the stations. For example, for Switzerland, the 25m DEM DHM25 can be obtained [here](https://www.swisstopo.admin.ch/en/height-model-dhm25). The provided `io.ini` expects the DEM to be in ASC format, and to be called `dem.asc`, but this can be changed in the `io.ini` file.
2. Create a list of stations in `stn.lst`
3. Run: `./horizons > horizons.txt`

Now, the file `horizons.txt` can be provided as `INFILE` in the [TauCLDGenerator](https://meteoio.slf.ch/doc-dev/html/classmio_1_1TauCLDGenerator.html) or [AllSkyLWGenerator](https://meteoio.slf.ch/doc-dev/html/classmio_1_1AllSkyLWGenerator.html) generators.

# Tip
To generate a `stn.lst` file for all *smet files in a certain directory, you can use the bash/awk one-liner below:

```
awk -F= 'BEGIN {print "[InputEditing]"} {if(/station_id/) {vid=$NF}; if(/latitude/) {lat=$NF}; if(/longitude/) {lon=$NF}; if(/altitude/) {alt=$NF}; if(/\[DATA\]/) {n++; printf "VSTATION%d = latlon %f %f %f\n", n, lat, lon, alt; printf "VID%d = %s\n", n, vid}}' /path/to/smet/*smet > stn.lst
```

# Note
The provided `dem.asc` and `stn.lst` are for demonstration purposes only, and allow testing of the tool. However, the `dem.asc` has too low accuracy for any useful applications.
