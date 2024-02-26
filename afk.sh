#!/bin/sh


#bash afk.sh | sort -t',' -k2 -nr | pcregrep "1[;].*[;]1[;].*|1[;].{0,2}[;]1[;].{0,2}"
#join -t";" -1 1 -2 1 <(cat input1.txt | sort -k1) <(cat input2.txt | sort -k1)
#awk -F' ' -v OFS=',' '{x=$1;$1="";a[x]=a[x]$0}END{for(x in a)print x, a[x]}'
# sort | uniq -c | sort -k1 -nr

java -jar NW_HD.jar -i query.txt -k 4 -h 0 | sed 's/(Start: /,/g' | sed 's/),/,/g' | sed 's/Query Name: //g' | sed 's/Ref Name: //g' | sed 's/ K-mer Query: //g' | sed 's/K-mer Ref: //g' | sed 's/ Hamming Distance: //g' | sed 's/ //g' | sort -t',' -k1 -n | sed 's/ /,/g' | awk -F "," '{print $4,$6,$7,$1}' | sed 's/ /,/g' | sed 's/ /,/g' | sort -t',' -k1 -n | awk -F"," '{if(NR>1) print $0, $2 - prev; prev=$2}' | awk -F"," '{if(NR>1) print $0, $3 - prev; prev=$3}'| sed 's/ /;+/g'   > input1.txt

java -jar NW_HD.jar -i reference.txt -k 4 -h 0 | sed 's/(Start: /,/g' | sed 's/),/,/g' | sed 's/Query Name: //g' | sed 's/Ref Name: //g' | sed 's/ K-mer Query: //g' | sed 's/K-mer Ref: //g' | sed 's/ Hamming Distance: //g' | sed 's/ //g' | sort -t',' -k1 -n | sed 's/ /,/g' | awk -F "," '{print $4,$6,$7,$1}' | sed 's/ /,/g' | sed 's/ /,/g' | sort -t',' -k1 -n | awk -F"," '{if(NR>1) print $0, $2 - prev; prev=$2}' | awk -F"," '{if(NR>1) print $0, $3 - prev; prev=$3}'| sed 's/ /;*/g'   > input2.txt


cat input1.txt input2.txt









#bash afk.sh | awk -F';' -v OFS=',' '{x=$1;$1="";a[x]=a[x]$0}END{for(x in a)print x, a[x]}' | sed 's/,,/|/g' | awk -F'|' '{print $2"|"$1}' | sed 's/,+/;/g' | sed 's/,[*]/;/g' | sed 's/^+//g' | sed 's/,/+/g' | sed 's/;/,/g' | head -2 | sed 's/^[0-9]*/"&"/g' | awk 'BEGIN{print "**,*Sepal.Length*,*Sepal.Width*,*Petal.Length*,*Petal.Width*,*Species*"}; {print}; END{print "END"}' | sed 's/END//g' |  awk 'NF > 0' | sed 's/*/"/g' | sed 's/|/,/g'  | sed 's/+/_/g' > R_IMBA_PLEASE.txt


#my_data <- iris
#head(my_data)

#write.csv(my_data,"/home/kay/Dokumente/CoboTechnologies/out_R.test.txt")
#X <- read.csv("/home/kay/Dokumente/CoboTechnologies/worskplt.txt")
# Color by groups; auto.key = TRUE to show legend
#cloud(Sepal.Length ~ Sepal.Length * Petal.Width, 
 #      group = Species, data = X,
  #     auto.key = FALSE)




#java -jar NW_HD.jar -i input.txt -k 4 -h 0 | sed 's/(Start: /,/g' | sed 's/),/,/g' | sed 's/Query Name: //g' | sed 's/Ref Name: //g' | sed 's/ K-mer Query: //g' | sed 's/K-mer Ref: //g' | sed 's/ Hamming Distance: //g' | sed 's/ //g' | sort -t',' -k4 -n | sed 's/ /,/g' | awk -F "," '{print $1,$4,$6,$7}' | sed 's/ /,/g' | awk -F"," '{if(NR>1) print $0, $3 - prev; prev=$3}' | awk -F"," '{if(NR>1) print $0, $2 - prev; prev=$2}' | awk -F"," '{if(NR>1) print $0, $3 - prev; prev=$4}' | awk -F"," '{if(NR>1) print $0, $4 - prev; prev=$3}' | awk -F"," '{print $2,"|",$0}' | sed 's/ /,/g' | awk -F"," '{print $(NF-3),$(NF-2),$(NF-1),$(NF)}' | sed 's/FRW//g' |  awk -F" " '{if(NR>1) print $0, $3 - prev; prev=$3}' | egrep "[0-1]$"  | awk '{print NR"*",$0}' | sed 's/ /,/g' | sed 's/^/"/g' | awk 'BEGIN{print "**,*Sepal.Length*,*Sepal.Width*,*Petal.Length*,*Petal.Width*,*Species*"}; {print}; END{print "END"}' | sed 's/END//g' | sed 's/*/"/g' | awk 'NF > 0' | sed 's/FRW//g' 
