#!/bin/bash
# C language compiler using gcc
# first version 26-10-2022

Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;93m'       # Yellow
Blue='\033[0;94m'         # Blue
Purple='\033[0;95m'       # Purple
NC='\033[0m'       		  	# Text Reset

clear
printf "compc.sh\t 26-10-2022\tv.3 \n"

function interface {
  while : 
  do
	echo ""
	echo "1. Compile with warrings"
	echo "2. Compile and run"
	echo "3. Compile all"
	printf "${Yellow}4. ${NC}Show .c .out\t"
	printf "${Yellow}0. ${NC}Exit\n"
	printf "${Red}T. ${NC}Compile last\t"
	printf "${Red}R. ${NC}Run last\n"
	read -p "Select: " uin
	  case $uin in 
	  	0) 	exit 1;;
	    1)	read -p "file name: " file
					compile;;

			2)	read -p "file name: " file
					compile
					sleep 0.1
					tmp=${file%.c}.out
					printf "${Blue}${tmp}${NC}\n"
					echo $(./$tmp)
					echo -e "\n\n\n\n";;

			3)	compile_all;;

			4)  pwd
					printf "${Blue}"
					ls *.c
					printf "${NC}"
					printf "${Green}"
					ls *.out
					printf "${NC}";;

			T|t)	compile_again;;

			R|r)	tmp=${file%.c}.out
						printf "${Blue}${tmp}${NC}\n"
						echo $(./$tmp)
						echo -e "\n\n\n\n";;

			*) 	printf "${Red}${uin} - No avalible option.${NC}";;
		esac
  done
}

function compile {
  if [[ $file != *".c"* ]]; then
  	file+=".c"
  fi
  gcc -g3 -o3 "$file" -o "${file%.c}.out"
  printf "${Green}${file} Compiled.${NC}\n"
}

function compile_again {
	echo $file
  gcc -g3 -o3 "$file" -o "${file%.c}.out"
  printf "${Green}${file} Compiled.${NC}\n"
}

function compile_all {
  for i in *.c
	do
      gcc -g3 -o3 "$i" -o "${i%.c}.out"
      printf "${Green}${i} Compiled.${NC}\n"
  done
}

# Main
var=`pwd`
interface