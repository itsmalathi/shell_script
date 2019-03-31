#Make array of json using some condition
extract_domain=$(awk '
	BEGIN { 
		FS=" "
		print "[";
	}
	{ 
		if($4 == "CONNECT")
		{
			arr[$3]++
		}
	}
END { 
	for (a in arr) {
		printf "%s{\"domain\": \"%s\", \"count\": \"%s\", \"category\": \"\"}" ,
		separator, a, arr[a]
		separator = ", "
	}
	print "]" 

} ' < $1)

echo "extract_domain" $extract_domain
#To sort the json array based on some key (Ascending order)
sorted_array=$(jq 'sort_by(.count)' <(echo $extract_domain ))
echo $sorted_array
#To reverse the json array
reversed_array=$(jq 'reverse' <(echo $sorted_array))
#To extarct 5 index value from json object
jq .[0:5] <(echo $reversed_array) > output.json
#To extract all array
jq .[] <(echo $reversed_array)
#To give dynamic input length
jq .[:$2] <(echo $reversed_array)

# #ARRAY
# my_array=(red orange green)
# value='green'

# for i in "${!my_array[@]}"; do
#    if [[ "${my_array[$i]}" = "${value}" ]]; then
#        echo "${i}";
#    fi
# done