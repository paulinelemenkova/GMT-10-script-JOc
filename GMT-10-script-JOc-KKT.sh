#!/bin/sh
# Purpose: coastline basemap in Mercator oblique projection (here: Kuril-Kamchatka Trench)
# GMT modules: pscoast, pstext, psconvert
# Step-1. Generate a file
ps=GMT_JOc_KKT.ps
# Step-2. GMT set up
gmt set FORMAT_GEO_MAP=dddF \
    MAP_FRAME_PEN dimgray \
    MAP_FRAME_WIDTH 0.1c \
    MAP_TITLE_OFFSET 0.5c \
    MAP_ANNOT_OFFSET 0.1c \
    MAP_TICK_PEN_PRIMARY thinner,dimgray \
    MAP_GRID_PEN_PRIMARY thinner,dimgray \
    MAP_ANNOT_OFFSET_PRIMARY 0.1c \
    FONT_TITLE 12p,Palatino-Roman,black \
    FONT_ANNOT_PRIMARY 7p,Palatino-Roman,dimgray \
    FONT_ANNOT_SECONDARY 7p,Palatino-Roman,dimgray \
    FONT_LABEL 7p,Palatino-Roman,dimgray \
# Step-3. Overwrite defaults of GMT
gmtdefaults -D > .gmtdefaults
# Step-4. Add coastline
gmt pscoast -R140/38/170/60r -JOc155/50/155/210/6i -P \
    -Bxa4g4f1 -Bya2g2f1 -Df -B+t"Coastline of the Kuril-Kamchatka area" \
    -Gnavajowhite -Wthinnest \
    -Slightcyan \
    -TdjBR+w0.4i+l+o0.15i \
    -Lx5.6i/-0.7i+c50+w1000k+l"Scale, km"+f \
    -UBL/-15p/-45p -K > $ps
# Step-5. Add footnote
gmt pstext -R0/8.5/0/11 -Jx1i -F+f7p,Helvetica,dimgray+jCB -N -O >> $ps << EOF
3.5 -0.7 Mercator oblique projection center: 155\232/50\232, pole: 155\232/210\232
EOF
# Step-6. Convert to image file using GhostScript (portrait orientation, 720 dpi)
gmt psconvert GMT_JOc_KKT.ps -A0.2c -E720 -Tj -P -Z
