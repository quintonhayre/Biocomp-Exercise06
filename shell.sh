#USAGE: bash shell.sh wages.csv
#1: unique gender-yearsExperience combinations for a csv, gender in the first column and yearsExperience in a second column, space separating the two columns, rows should be sorted first by gender and then by yearsExperience
cat *.csv|sed '1d' |cut -d ,  -f 1,2|tr ',' ' '| sed -E -e 's/ ([0-9])$/ 0\1/'| sort -t , -k2 -g -k1 | uniq > uniquegenderwage.txt

#2:
#a: the gender, yearsExpe- rience, and wage for the highest earner
echo "Highest earner (Gender, Years Experience, wage in $)"
cat *.csv |sed '1d'| sed -E -e 's/,([0-9]\.?[0-9]*)$/,0\1/'|sort -t , -k 4 -g | tail -n 1 | cut -d ,  -f 1,2,4
#b: the gender, yearsExperience, and wage for the lowest earner
echo "Lowest earner (Gender, Years Experience, wage in $)"
cat *.csv |sed '1d'| sed -E -e 's/,([0-9]\.?[0-9]*)$/,0\1/'|sort -t , -k 4 -g | head -n 1 | cut -d ,  -f 1,2,4
#c: the number of females in the top ten earners in this data set
echo "Number of females in the top 10 earners:"
cat *.csv | sed -E -e 's/,([0-9]\.?[0-9]*)$/,0\1/'|sort -t , -k 4 -g | tail -n 10 | grep -w "female" | wc -l

#3: the effect of graduating college (12 vs. 16 years of school) on the minimum wage for earners in this dataset
min_16=$(cat *.csv | sed -E -e 's/,([0-9]\.?[0-9]*)$/,0\1/'| cut -d ,  -f 3,4 | grep -E "16," | sort -k 2 | head -n 1 | cut -d , -f 2)
min_12=$(cat *.csv | sed -E -e 's/,([0-9]\.?[0-9]*)$/,0\1/'| cut -d ,  -f 3,4 | grep -E "12," | sort -k 2 | head -n 1 | cut -d , -f 2)
echo "Wage difference between lowest earners of college vs high school grads"
echo "$min_16 - $min_12" | bc

