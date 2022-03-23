icons_dir="assets/icons"
images_dir="assets/images"
currentPackage=`basename "$PWD"`
output="lib/generated_images.dart"
touch "$output"
echo  > $output

if [ "$(ls -A $icons_dir)" ]; then
    echo "class Ic {" >> $output
    for entry in "$icons_dir"/*
        do
        fname=`basename $entry`
        name="${fname%%.*}"
        lowercase=$(echo "$name" | awk '{print tolower($0)}')
        camelCase=$(echo "$lowercase" | perl -pe 's/_([a-z])/uc($1)/ge')
        if [[ $camelCase != "2" ]]; then
        if [[ $camelCase != "3" ]]; then
        echo "  static const $camelCase = 'packages/$currentPackage/$entry';" >> $output
        fi
        fi
    done
    echo "}
" >> $output
else
    echo ''
fi

if [ "$(ls -A $images_dir)" ]; then
    echo "class Img {" >> $output
    for entry in "$images_dir"/*
        do
        fname=`basename $entry`
        name="${fname%%.*}"
        lowercase=$(echo "$name" | awk '{print tolower($0)}')
        camelCase=$(echo "$lowercase" | perl -pe 's/_([a-z])/uc($1)/ge')
        if [[ $camelCase != "2" ]]; then
        if [[ $camelCase != "3" ]]; then
        echo "  static const $camelCase = 'packages/$currentPackage/$entry';" >> $output
        fi
        fi
    done
    echo "}
" >> $output
else
    echo ''
fi

