#!/bin/bash
shopt -s nullglob
while :
do
    files=(in/*.pdf)

    if (( ${#files[@]} >= 2 )); # todo
    then
        echo "Detected ${#files[@]} files:"
        #echo ${files[@]}

        pages_0=$(pdftk ${files[0]} dump_data | grep NumberOfPages | sed 's/[^0-9]*//')
        echo "${files[0]} has $pages_0 pages"
        
        pages_1=$(pdftk ${files[1]} dump_data | grep NumberOfPages | sed 's/[^0-9]*//')
        echo "${files[1]} has $pages_1 pages"

        if (( $pages_0 == $pages_1 ));
        then
            merged_name=$(basename ${files[0]})
            merged_name="out/${merged_name%.*}_merged.pdf"
            echo "Merging to ${merged_name} ..."
            pdftk A=${files[0]} B=${files[1]} shuffle A Bend-1 output ${merged_name}
            rm ${files[0]}
            rm ${files[1]}
            echo "Done"
        else
            echo "Page missmach, remove ${files[0]}"
            rm ${files[0]}
        fi
    else
        echo "Found only ${#files[@]} files"
    fi

    sleep 60
done
