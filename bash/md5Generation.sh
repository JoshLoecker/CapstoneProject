cores=$1

for item in "temp_results/"*; do
    folder_name=$(basename -- "$item")
    output_folder="../results/bash/md5/$folder_name"
    mkdir -p "$output_folder"
    find -s "./temp_results/$folder_name" -type f -exec md5 -r {} \; > "$output_folder/core.count.$cores"
done
