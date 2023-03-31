#!/bin/bash
# $1 => domain.com

mkdir $1

cd $1 

mkdir subdomain_outputs_$1

cd subdomain_outputs_$1

echo -e "\e[1;32mEnumerating subdomains using amass \e[0m"
amass enum --passive -norecursive -noalts -d $1 -v -o amass_$1.txt
echo ""
echo -e "\e[1;32mEnumerating subdomains using assetfinder \e[0m"
assetfinder --subs-only $1 | tee -a assetfinder_$1.txt
echo ""
echo -e "\e[1;32mEnumerating subdomains using subfinder \e[0m"
subfinder -d $1 -o subfinder_$1.txt
echo ""
echo -e "\e[1;32mEnumerating subdomains using knockpy \e[0m"
knockpy $1 -o knockpy_$1
echo ""
echo -e "\e[1;32mEnumerating subdomains using findomain \e[0m"
findomain -t $1 -u findomain_$1.txt 
echo ""

#combining all the subdomain finder outputs
echo "\e[1;33mCombining all the outputs into one"
cat amass_$1.txt assetfinder_$1.txt subfinder_$1.txt findomain_$1.txt | sort -u | tee -a domain_$1.txt




