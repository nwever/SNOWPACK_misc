Script to make an animation of a SNOWPACK simulation

### Requirements
- `mawk` / `awk`
- `gnuplot`
- `ffmpeg`

### Steps
1. Create a gnuplot plotting file, using: `bash make_animation.sh <*pro file> > a.gnu`
2. Execute gnuplot: `gnuplot a.gnu`
3. Convert collection of PNGs to mov: `ffmpeg -i %d.png -codec png out.mov`
4. Convert mov to mp4:<br>
   Either: `ffmpeg -i out.mov -profile:v baseline -level 3.0 -c:v libx264 -pix_fmt yuv420p -vf format=yuv420p out.mp4`<br>
   Or: `ffmpeg -i out.mov -vf scale="trunc(iw/2)*2:trunc(ih/2)*2" -c:v libx264 -profile:v high -pix_fmt yuv420p -g 25 -r 25 out.mp4`<br>

### Known issues
- only primary grain type used for plotting
- any possible surface hoar (top element in 0513) is ignored
