do_rotation=0	# 1: Rotate profile, 0: No rotation
yskip=3			# Plot every yskip layer in the *pro file
nskip=1			# Plot every nskip timesteps in the *pro file

mawk -F, -v do_rotation=${do_rotation} -v yskip=${yskip} -v nskip=${nskip} 'BEGIN {rot=60; print "set term pngcairo enhanced size 2000,1000 font \"Helvetica,24\"; set datafile missing \"-999\"; unset xl; unset yl; unset xtics; unset ytics; unset border; set xrange[0:1]; set yrange[0:1]; set zrange[0:170]; set ztics(\"-1.0\" -100, \"-0.5\" -50, \"0.0\" 0, \"0.5\" 50, \"1.0\" 100, \"1.5\" 150, \"2.0\" 200, \"2.5\" 250)"; sl=0} \
function hex2dec(h,i,x,v) { \
	h=tolower(h);sub(/^0x/,"",h); \
	for(i=1;i<=length(h);++i) { \
		x=index("0123456789abcdef",substr(h,i,1)); \
		if(!x) return"NaN"; \
		v=(16*v)+x-1; \
	} \
	return v; \
} \
function MonthToStr(val) { \
	if(val==1) return "January"; \
	if(val==2) return "February"; \
	if(val==3) return "March"; \
	if(val==4) return "April"; \
	if(val==5) return "May"; \
	if(val==6) return "June"; \
	if(val==7) return "July"; \
	if(val==8) return "August"; \
	if(val==9) return "September"; \
	if(val==10) return "October"; \
	if(val==11) return "November"; \
	if(val==12) return "December"; \
} \
function colT(val) { \
pr[0]=-20; pv[0]="0000FF"; \
pr[1]=-10; pv[1]="FFFFFF"; \
pr[2]=0; pv[2]="FF0000"; \
pn=3; min=pr[0]; max=pr[pn-1]; \
if(val==-999) {return "0xFFFFFF"} \
if(val<pr[0]) {return sprintf("0x%s", pv[0])} \
if(val>=pr[pn-1]) {return sprintf("0x%s", pv[pn-1])} \
for(ii=0; ii<pn-1; ii++) { \
	if(val>=pr[ii] && val < pr[ii+1]) { \
		r1=hex2dec(substr(pv[ii],1,2)); \
		r2=hex2dec(substr(pv[ii+1],1,2)); \
		g1=hex2dec(substr(pv[ii],3,2)); \
		g2=hex2dec(substr(pv[ii+1],3,2)); \
		b1=hex2dec(substr(pv[ii],5,2)); \
		b2=hex2dec(substr(pv[ii+1],5,2)); \
		r=r1+(r2-r1)/(pr[ii+1]-pr[ii])*(val-pr[ii])
		g=g1+(g2-g1)/(pr[ii+1]-pr[ii])*(val-pr[ii])
		b=b1+(b2-b1)/(pr[ii+1]-pr[ii])*(val-pr[ii])
		return sprintf("0x%02x%02x%02x", int(r+0.5), int(g+0.5), int(b+0.5));\
	} \
}; return sprintf("0x%s", pv[pn-1])} \
function colrho(val) { \
pr[0]=150; pv[0]="FFFFCC"; \
pr[1]=200; pv[1]="C7E9B4"; \
pr[2]=250; pv[2]="7FCDBB"; \
pr[3]=300; pv[3]="41B6C4"; \
pr[4]=350; pv[4]="2C7FB8"; \
pr[5]=400; pv[5]="2C7FB8"; \
pr[6]=450; pv[6]="253494"; \
pr[7]=900; pv[7]="FFFF00"; \
pn=8; min=pr[0]; max=pr[pn-1]; \
if(val==-999) {return "0xFFFFFF"} \
if(val<pr[0]) {return sprintf("0x%s", pv[0])} \
if(val>=pr[pn-1]) {return sprintf("0x%s", pv[pn-1])} \
for(ii=0; ii<pn-1; ii++) { \
	if(val>=pr[ii] && val < pr[ii+1]) { \
		r1=hex2dec(substr(pv[ii],1,2)); \
		r2=hex2dec(substr(pv[ii+1],1,2)); \
		g1=hex2dec(substr(pv[ii],3,2)); \
		g2=hex2dec(substr(pv[ii+1],3,2)); \
		b1=hex2dec(substr(pv[ii],5,2)); \
		b2=hex2dec(substr(pv[ii+1],5,2)); \
		r=r1+(r2-r1)/(pr[ii+1]-pr[ii])*(val-pr[ii])
		g=g1+(g2-g1)/(pr[ii+1]-pr[ii])*(val-pr[ii])
		b=b1+(b2-b1)/(pr[ii+1]-pr[ii])*(val-pr[ii])
		return sprintf("0x%02x%02x%02x", int(r+0.5), int(g+0.5), int(b+0.5));\
	} \
}; return sprintf("0x%s", pv[pn-1])} \
function collwc(val) { \
pr[0]=0; pv[0]="999999"; \
pr[1]=0.000001; pv[1]="EFF3FF"; \
pr[2]=2; pv[2]="C6DBEF"; \
pr[3]=4; pv[3]="9ECAE1"; \
pr[4]=6; pv[4]="6BAED6"; \
pr[5]=8; pv[5]="3182BD"; \
pr[6]=10; pv[6]="08519C"; \
pr[7]=20; pv[7]="BA21C2"; \
pn=8; min=pr[0]; max=pr[pn-1]; \
if(val==-999) {return "0xFFFFFF"} \
if(val<pr[0]) {return sprintf("0x%s", pv[0])} \
if(val>=pr[pn-1]) {return sprintf("0x%s", pv[pn-1])} \
for(ii=0; ii<pn-1; ii++) { \
	if(val>=pr[ii] && val < pr[ii+1]) { \
		r1=hex2dec(substr(pv[ii],1,2)); \
		r2=hex2dec(substr(pv[ii+1],1,2)); \
		g1=hex2dec(substr(pv[ii],3,2)); \
		g2=hex2dec(substr(pv[ii+1],3,2)); \
		b1=hex2dec(substr(pv[ii],5,2)); \
		b2=hex2dec(substr(pv[ii+1],5,2)); \
		r=r1+(r2-r1)/(pr[ii+1]-pr[ii])*(val-pr[ii])
		g=g1+(g2-g1)/(pr[ii+1]-pr[ii])*(val-pr[ii])
		b=b1+(b2-b1)/(pr[ii+1]-pr[ii])*(val-pr[ii])
		return sprintf("0x%02x%02x%02x", int(r+0.5), int(g+0.5), int(b+0.5));\
	} \
}; return sprintf("0x%s", pv[pn-1])} \
function colsimpleshape(val) { \
pr[0]=100; pv[0]="00FF00"; \
pr[1]=199; pv[1]="00FF00"; \
pr[2]=200; pv[2]="228B22"; \
pr[3]=299; pv[3]="228B22"; \
pr[4]=300; pv[4]="FFB6C1"; \
pr[5]=399; pv[5]="FFB6C1"; \
pr[6]=400; pv[6]="ADD8E6"; \
pr[7]=499; pv[7]="ADD8E6"; \
pr[8]=500; pv[8]="0000FF"; \
pr[9]=599; pv[9]="0000FF"; \
pr[10]=600; pv[10]="FF00FF"; \
pr[11]=699; pv[11]="FF00FF"; \
pr[12]=700; pv[12]="FF0000"; \
pr[13]=799; pv[13]="FF0000"; \
pr[14]=800; pv[14]="00FFFF"; \
pr[15]=899; pv[15]="00FFFF"; \
pn=16; min=pr[0]; max=pr[pn-1]; \
if(val==-999 || val<pr[0]) {return "0xFFFFFF"} \
if(val>pr[pn-1]) {return sprintf("0x%s", pv[pn-1])} \
for(ii=0; ii<pn-1; ii++) { \
	if(val>pr[ii] && val <= pr[ii+1]) { \
		r1=hex2dec(substr(pv[ii],1,2)); \
		r2=hex2dec(substr(pv[ii+1],1,2)); \
		g1=hex2dec(substr(pv[ii],3,2)); \
		g2=hex2dec(substr(pv[ii+1],3,2)); \
		b1=hex2dec(substr(pv[ii],5,2)); \
		b2=hex2dec(substr(pv[ii+1],5,2)); \
		r=r1+(r2-r1)/(pr[ii+1]-pr[ii])*(val-pr[ii])
		g=g1+(g2-g1)/(pr[ii+1]-pr[ii])*(val-pr[ii])
		b=b1+(b2-b1)/(pr[ii+1]-pr[ii])*(val-pr[ii])
		return sprintf("0x%02x%02x%02x", int(r+0.5), int(g+0.5), int(b+0.5));\
	} \
}; return sprintf("0x%s", pv[pn-1])} \
function newFrame(frameno, rotation) { \
printf "set output \"%d.png\"; set view 80, %f, 1, 1; set multiplot layout 1,4;\n", frameno, rotation; \
} \
function SeaLevel() { \
if (sl!=-999) {return}; \
printf "set object %d polygon front from -0.35,-0.35,%f to -0.35,1.35,%f to 1.35,1.35,%f to 1.35,-0.35,%f fillstyle solid border fillcolor rgb \"#bb42b6f5\"\n", n+1, sl, sl, sl, sl; n++; \
} \
{if(/\[DATA\]/) {data=1}; if(data==1 && $1==0500) {frame_in++; month=int(substr($2,4,2)); day=int(substr($2,1,2)); timestr=sprintf("%s %s", day, MonthToStr(month))} else if(data==1 && $1==0501 && frame_in%nskip==0) {z[0]=0; for(i=3; i<=NF; i++) {z[i-2]=$i}} \
else if(data==1 && $1==0502 && frame_in%nskip==0) {frame++; rot+=0.35*do_rotation; newFrame(frame, rot); print "set cbtics offset 0,.5;"; \
SeaLevel(); \
for(i=3; i<=NF; i+=yskip) {\
printf "set object %d polygon from 0,0,%f to 0,1,%f to 0,1,%f to 0,0,%f to 0,0,%f fillstyle solid fillcolor rgb \"%s\"\n", n+1, z[i-2-yskip], z[i-2-yskip], z[i-2], z[i-2], z[i-2-yskip], colrho($i); n++; \
printf "set object %d polygon from 1,0,%f to 1,1,%f to 1,1,%f to 1,0,%f to 1,0,%f fillstyle solid fillcolor rgb \"%s\"\n", n+1, z[i-2-yskip], z[i-2-yskip], z[i-2], z[i-2], z[i-2-yskip], colrho($i); n++; \
printf "set object %d polygon from 1,1,%f to 0,1,%f to 0,1,%f to 1,1,%f to 1,1,%f fillstyle solid fillcolor rgb \"%s\"\n", n+1, z[i-2-yskip], z[i-2-yskip], z[i-2], z[i-2], z[i-2-yskip], colrho($i); n++; \
printf "set object %d polygon from 0,0,%f to 1,0,%f to 1,0,%f to 0,0,%f to 0,0,%f fillstyle solid fillcolor rgb \"%s\"\n", n+1, z[i-2-yskip], z[i-2-yskip], z[i-2], z[i-2], z[i-2-yskip], colrho($i); n++; \
printf "set object %d polygon front from 0,0,%f to 0,1,%f to 1,1,%f to 1,0,%f to 0,0,%f fillstyle empty border fillcolor rgb \"gray\"\n", n+1, z[i-2], z[i-2], z[i-2], z[i-2], z[i-2], z[i-2]; n++;\
if(i==NF || i+yskip>NF) {printf "set object %d polygon front from 0,0,%f to 0,1,%f to 1,1,%f to 1,0,%f to 0,0,%f fillstyle solid border fillcolor rgb \"%s\"\n", n+1, z[i-2], z[i-2], z[i-2], z[i-2], z[i-2], colrho($i); n++;}\
}; printf "set origin 0.25,-0.1; set size 0.25, 1; splot -999 w p notitle; unset for [n=1:%d] object n; set cblabel \"Density (kg / m^3)\" offset 0,1; set palette defined (150 \"#FFFFCC\", 200 \"#C7E9B4\", 250 \"#7FCDBB\", 300 \"#41B6C4\", 350 \"#2C7FB8\", 400 \"#2C7FB8\", 450 \"#253494\", 900 \"#FFFF00\"); set cbrange[100:800]; set colorbox horizontal user size 0.21, 0.04 origin 0.27, 0.95; plot -999 w p palette notitle;\n", n, m} \
else if(data==1 && $1==0503 && frame_in%nskip==0) { \
SeaLevel(); \
for(i=3; i<=NF; i+=yskip) { \
printf "set object %d polygon from 0,0,%f to 0,1,%f to 0,1,%f to 0,0,%f to 0,0,%f fillstyle solid fillcolor rgb \"%s\"\n", n+1, z[i-2-yskip], z[i-2-yskip], z[i-2], z[i-2], z[i-2-yskip], colT($i); n++; \
printf "set object %d polygon from 1,0,%f to 1,1,%f to 1,1,%f to 1,0,%f to 1,0,%f fillstyle solid fillcolor rgb \"%s\"\n", n+1, z[i-2-yskip], z[i-2-yskip], z[i-2], z[i-2], z[i-2-yskip], colT($i); n++; \
printf "set object %d polygon from 1,1,%f to 0,1,%f to 0,1,%f to 1,1,%f to 1,1,%f fillstyle solid fillcolor rgb \"%s\"\n", n+1, z[i-2-yskip], z[i-2-yskip], z[i-2], z[i-2], z[i-2-yskip], colT($i); n++; \
printf "set object %d polygon from 0,0,%f to 1,0,%f to 1,0,%f to 0,0,%f to 0,0,%f fillstyle solid fillcolor rgb \"%s\"\n", n+1, z[i-2-yskip], z[i-2-yskip], z[i-2], z[i-2], z[i-2-yskip], colT($i); n++; \
printf "set object %d polygon front from 0,0,%f to 0,1,%f to 1,1,%f to 1,0,%f to 0,0,%f fillstyle empty border fillcolor rgb \"gray\"\n", n+1, z[i-2], z[i-2], z[i-2], z[i-2], z[i-2]; n++;\
if(i==NF || i+yskip>NF) {printf "set object %d polygon front from 0,0,%f to 0,1,%f to 1,1,%f to 1,0,%f to 0,0,%f fillstyle solid border fillcolor rgb \"%s\"\n", n+1, z[i-2], z[i-2], z[i-2], z[i-2], z[i-2], colT($i); n++;} \
}; printf "set origin 0.5,-0.1; set size 0.25, 1; splot -999 w p notitle; unset for [n=1:%d] object n; set cblabel \"Temperature ({/Symbol \260}C)\" offset 0,1; set palette defined (-3 \"blue\", 0 \"white\", 3 \"red\"); set cbrange[-20:0]; set colorbox horizontal user size 0.21, 0.04 origin 0.52, 0.95; plot -999 w p palette notitle;\n", n;} \
else if(data==1 && $1==0506 && frame_in%nskip==0) { \
SeaLevel(); \
for(i=3; i<=NF; i+=yskip) { \
printf "set object %d polygon from 0,0,%f to 0,1,%f to 0,1,%f to 0,0,%f to 0,0,%f fillstyle solid fillcolor rgb \"%s\"\n", n+1, z[i-2-yskip], z[i-2-yskip], z[i-2], z[i-2], z[i-2-yskip], collwc($i); n++; \
printf "set object %d polygon from 1,0,%f to 1,1,%f to 1,1,%f to 1,0,%f to 1,0,%f fillstyle solid fillcolor rgb \"%s\"\n", n+1, z[i-2-yskip], z[i-2-yskip], z[i-2], z[i-2], z[i-2-yskip], collwc($i); n++; \
printf "set object %d polygon from 1,1,%f to 0,1,%f to 0,1,%f to 1,1,%f to 1,1,%f fillstyle solid fillcolor rgb \"%s\"\n", n+1, z[i-2-yskip], z[i-2-yskip], z[i-2], z[i-2], z[i-2-yskip], collwc($i); n++; \
printf "set object %d polygon from 0,0,%f to 1,0,%f to 1,0,%f to 0,0,%f to 0,0,%f fillstyle solid fillcolor rgb \"%s\"\n", n+1, z[i-2-yskip], z[i-2-yskip], z[i-2], z[i-2], z[i-2-yskip], collwc($i); n++; \
printf "set object %d polygon front from 0,0,%f to 0,1,%f to 1,1,%f to 1,0,%f to 0,0,%f fillstyle empty border fillcolor rgb \"gray\"\n", n+1, z[i-2], z[i-2], z[i-2], z[i-2], z[i-2]; n++;\
if(i==NF || i+yskip>NF) {printf "set object %d polygon front from 0,0,%f to 0,1,%f to 1,1,%f to 1,0,%f to 0,0,%f fillstyle solid border fillcolor rgb \"%s\"\n", n+1, z[i-2], z[i-2], z[i-2], z[i-2], z[i-2], collwc($i); n++;} \
}; printf "set origin 0.75,-0.1; set size 0.25, 1; splot -999 w p notitle; unset for [n=1:%d] object n; set cblabel \"Liquid water content (%%)\" offset 0,1; set palette defined (0 \"#999999\", 0.000001 \"#EFF3FF\", 2 \"#C6DBEF\", 4 \"#9ECAE1\", 6 \"#6BAED6\", 8 \"#3182BD\", 10 \"#08519C\", 20 \"#BA21C2\"); set cbrange[0:20]; set colorbox horizontal user size 0.21, 0.04 origin 0.77, 0.95; plot -999 w p palette notitle;\n", n;} \
else if(data==1 && $1==0513 && frame_in%nskip==0) { \
SeaLevel(); \
for(i=3; i<=NF-1; i+=yskip) { \
printf "set object %d polygon from 0,0,%f to 0,1,%f to 0,1,%f to 0,0,%f to 0,0,%f fillstyle solid fillcolor rgb \"%s\"\n", n+1, z[i-2-yskip], z[i-2-yskip], z[i-2], z[i-2], z[i-2-yskip], colsimpleshape($i); n++; \
printf "set object %d polygon from 1,0,%f to 1,1,%f to 1,1,%f to 1,0,%f to 1,0,%f fillstyle solid fillcolor rgb \"%s\"\n", n+1, z[i-2-yskip], z[i-2-yskip], z[i-2], z[i-2], z[i-2-yskip], colsimpleshape($i); n++; \
printf "set object %d polygon from 1,1,%f to 0,1,%f to 0,1,%f to 1,1,%f to 1,1,%f fillstyle solid fillcolor rgb \"%s\"\n", n+1, z[i-2-yskip], z[i-2-yskip], z[i-2], z[i-2], z[i-2-yskip], colsimpleshape($i); n++; \
printf "set object %d polygon from 0,0,%f to 1,0,%f to 1,0,%f to 0,0,%f to 0,0,%f fillstyle solid fillcolor rgb \"%s\"\n", n+1, z[i-2-yskip], z[i-2-yskip], z[i-2], z[i-2], z[i-2-yskip], colsimpleshape($i); n++; \
printf "set object %d polygon front from 0,0,%f to 0,1,%f to 1,1,%f to 1,0,%f to 0,0,%f fillstyle empty border fillcolor rgb \"gray\"\n", n+1, z[i-2], z[i-2], z[i-2], z[i-2], z[i-2]; n++;\
if(i==(NF-1) || i+yskip>(NF-1)) {printf "set object %d polygon front from 0,0,%f to 0,1,%f to 1,1,%f to 1,0,%f to 0,0,%f fillstyle solid border fillcolor rgb \"%s\"\n", n+1, z[i-2], z[i-2], z[i-2], z[i-2], z[i-2], colsimpleshape($i); n++;} \
}; printf "set origin 0,-0.1; set size 0.25, 1; splot -999 w p notitle; unset for [n=1:%d] object n; set cbrange[100:900]; set palette model RGB defined (100 \"0x00FF00\", 199 \"0x00FF00\", 200 \"0x228B22\", 299 \"0x228B22\", 300 \"0xFFB6C1\", 399 \"0xFFB6C1\", 400 \"0xADD8E6\", 499 \"0xADD8E6\", 500 \"0x0000FF\", 599 \"0x0000FF\", 600 \"0xFF00FF\", 699 \"0xFF00FF\", 700 \"0xFF0000\", 799 \"0xFF0000\", 800 \"0x00FFFF\", 899 \"0x00FFFF\"); set cblabel \"Grain shapes\" offset 0,-2.5; set cbtics (\"New snow\" 150, \"Decomposing\" 250, \"Rounded\" 350, \"Faceted\" 450, \"Depth hoar\" 550, \"Surface hoar\" 650, \"Melt forms\" 750, \"Ice\" 850); set cbtics rotate by 90 right font \",18\"; set colorbox horizontal user size 0.21, 0.04 origin 0.02, 0.95;\n", n; printf "set label %d \"%s\" at screen 0.05, screen 0.05 front font \",32\";\n", m+1, timestr; m++; printf "plot -1 w p palette notitle;\n"; printf "set cbtics auto rotate by 0 center; set cbtics offset 0,.5 font \",24\"; unset for [m=1:%d] label m; unset multiplot\n", m} \
} END {}' $1
