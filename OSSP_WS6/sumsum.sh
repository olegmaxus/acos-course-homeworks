#!/bin/bash

sum(){
ARR=("$@")
if [ "${#ARR[@]}" -gt 0 ] 2>/dev/null; then
	for elem in "${ARR[@]}"; do
		if [ "$elem" -ge 0 ] 2>/dev/null || [ "$elem" -lt 0 ] 2>/dev/null; then	
	    	((ar_sum+=$elem))
		else
			ar_sum="ERR"
			break
		fi
	done
else
	ar_sum=0
fi
echo $ar_sum
}

read -a ARR
read -a ARY
A=$(sum "${ARR[@]}")
#echo $A
B=$(sum "${ARY[@]}")
#echo $B
#echo $A
#echo $B


if [ "$B" -eq "$A" ] 2>/dev/null; then
	echo "Equal"
else
	echo "Not Equal"
fi
