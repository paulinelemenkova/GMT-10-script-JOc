#!/bin/sh
# Purpose: coastline basemap in Mercator oblique projection (here: Mariana Trench)
# GMT modules: pscoast, pstext, psconvert
# Step-1. Generate a file
ps=GMT_JOc_MT.ps
# Step-2. GMT set up
gmt set FORMAT_GEO_MAP=dddF \
    MAP_FRAME_PEN dimgray \
    MAP_FRAME_WIDTH 0.1c \
    MAP_TITLE_OFFSET 0.5c \
    MAP_ANNOT_OFFSET 0.1c \
    MAP_TICK_PEN_PRIMARY thinner,dimgray \
    MAP_GRID_PEN_PRIMARY thinner,dimgray \
    MAP_GRID_PEN_SECONDARY thinnest,dimgray \
    FONT_TITLE 12p,Palatino-Roman,black \
    FONT_ANNOT_PRIMARY 6p,Palatino-Roman,dimgray \
    FONT_LABEL 6p,Palatino-Roman,dimgray \
# Step-3. Overwrite defaults of GMT
gmtdefaults -D > .gmtdefaults
# Step-4. Add coastline
gmt pscoast -R120/5/160/30r -JOc140/17/140/150/6i -P \
-Bpxa4g4f1 -Bpya2g2f1 -Bsxg2 -Bsyg2 -Df -B+t"Study area: west Pacific Ocean, Mariana Trench" \
    -Gnavajowhite -Wthinnest \
    -Slightcyan \
    -TdjBR+w0.4i+l+o0.15i \
    -Lx14.0c/-1.2c+c50+w800k+l"Scale, km"+f \
    -UBL/-15p/-45p -K > $ps
# Step-5. Add footnote
gmt pstext -R0/10/0/10 -Jx1i -F+6p,Palatino-Roman,dimgray+jCB -N -O -K >> $ps << EOF
0.0 0.0 Mercator oblique projection center: 140\232/17\232, pole: 140\232/150\232
EOF
# Step-6. Add GMT logo
gmt logo -Dx6.2/-2.2+o0.1i/0.1i+w2c -O >> $ps
# Step-7. Convert to image file using GhostScript (portrait orientation, 720 dpi)
gmt psconvert GMT_JOc_MT.ps -A0.2c -E720 -Tj -P -Z
