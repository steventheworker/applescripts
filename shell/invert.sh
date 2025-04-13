if [ -z "$1" ]; then
   echo "No argument supplied"
   exit 1
fi

# config
quality=1.67

# Input PDF file
input_pdf="$1"

# Output PDF file
output_pdf="$1-inverted.pdf"

# Temporary directory to store image files
temp_dir="$HOME/temp_images"  # Use user's home directory for temporary files

# Create a temporary directory if it doesn't exist
mkdir -p "$temp_dir"

# Calculate DPI based on output dimensions and desired quality
dpis=$(convert -ping "$input_pdf" -format "%x\n" info:)
dpi=`echo "${dpis}" | head -1` # first line only
dpi=$(printf "%.2f" $(echo "$dpi*1.2*$quality" | bc -l)) #make slightly higher quality (1.0 = 120%)

# standard sheet of paper
# output_width=8.5
# output_height=11

# desired_width_pixels=$(echo "$output_width * $dpi / 1" | bc)
# desired_height_pixels=$(echo "$output_height * $dpi / 1" | bc)

# Convert each page of the PDF to an image and invert it
# convert -density "$dpi" -quality 100 "$input_pdf" -resize "${desired_width_pixels}x${desired_height_pixels}" "$temp_dir/page_%04d.jpg"
convert -density "$dpi" -quality 100 "$input_pdf" "$temp_dir/page_%04d.jpg"
mogrify -negate "$temp_dir"/*.jpg

# Convert the inverted images back to a PDF
convert "$temp_dir"/*.jpg "$output_pdf"

# Clean up temporary files
rm -r "$temp_dir"

