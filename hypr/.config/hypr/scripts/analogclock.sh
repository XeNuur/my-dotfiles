#!/usr/bin/env bash

OUT="$HOME/.cache/analog_clock.png"
W=1920
H=1080
CX=$((W / 2))
CY=$((H / 2))
R=300

FG="#ffffff"
ACCENT="#f38ba8"

# Time
HOUR=$(date +%I)
MIN=$(date +%M)

# Angles
H_ANGLE=$(echo "($HOUR + $MIN/60) * 30 - 90" | bc -l)
M_ANGLE=$(echo "$MIN * 6 - 90" | bc -l)

# Hand lengths
HR=$((R * 50 / 100))
MR=$((R * 75 / 100))

# Calculate hand endpoints
hx=$(echo "$CX + $HR * c($H_ANGLE * 0.0174533)" | bc -l)
hy=$(echo "$CY + $HR * s($H_ANGLE * 0.0174533)" | bc -l)

mx=$(echo "$CX + $MR * c($M_ANGLE * 0.0174533)" | bc -l)
my=$(echo "$CY + $MR * s($M_ANGLE * 0.0174533)" | bc -l)

magick -size ${W}x${H} xc:none \
  -stroke "$FG" -strokewidth 6 -fill none \
  -draw "circle $CX,$CY $((CX+R)),$CY" \
  -stroke "$FG" -strokewidth 8 \
  -draw "line $CX,$CY $hx,$hy" \
  -strokewidth 5 \
  -draw "line $CX,$CY $mx,$my" \
  -fill "$FG" -stroke none \
  -draw "circle $CX,$CY $((CX+6)),$CY" \
  "$OUT"

echo $OUT
