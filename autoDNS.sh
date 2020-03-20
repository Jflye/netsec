#!/bin/bash
nports=10000
domain=${1:?Domain pls}
script_dir=$(realpath "$(dirname "$0")")
if [[ "$domain" != `basename "$PWD"` ]]; then
	mkdir -p "$domain"
	cd "$domain" || exit 1
fi
amass enum -passive -d $domain | tee amass.txt
subfinder -d $domain | tee subfinder.txt
cat amass.txt subfinder.txt | sort -u > 1-domains.txt
echo "Found $(wc -l 1-domains.txt | cut -f1 -d ' ') subdomains"
# https://public-dns.info/nameservers.txt
massdns -o S --processes $(nproc) -r "$script_dir/nameservers.txt" -w massdns.txt 1-domains.txt
cat massdns.txt* 2>/dev/null > 2-massdns.txt
echo "Found $(wc -l 2-massdns.txt | cut -f1 -d ' ') resolvable subdomains"
cat 2-massdns.txt | grep ' A ' | cut -d ' ' -f 3 > 3-ips.txt
ports=$(nmap --top-ports $nports -v -oG - 2>/dev/null | perl -n -e '/TCP\(\d+;(.+?)\)/ && print $1')
sudo masscan -p$ports --rate=1000 -iL 3-ips.txt | tee 4-masscan.txt
proc() {
	line=$1
	ip=$(echo "$line" | cut -f3 -d ' ')
	host=$(echo "$line" | cut -f1 -d ' ' | sed 's/\.$//')
	open_ports=$(cat 4-masscan.txt | grep "$ip" | awk -F " " '{print $4}' | awk -F "/" '{print $1}' | sort -n | tr '\n' ',' | sed 's/,$//')
	if [[ -z "$open_ports" ]]; then
		return
	fi
	mkdir -p "${host}-${ip}"
	pushd "${host}-${ip}"  > /dev/null
	cat ../4-masscan.txt | grep "$ip" > masscan.txt
	echo
	echo "${host} (${ip})"
	echo $open_ports
	echo
	nmap -Pn -sV -sC -p$open_ports -oA nmap "$host"
	docker run --rm -i -v "$PWD:/tmp/EyeWitness" eyewitness --web --user-agent 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.132 Safari/537.36' --timeout 15 -d /tmp/EyeWitness/eyewitness -x /tmp/EyeWitness/nmap.xml
	popd > /dev/null
}
export -f proc
cat 2-massdns.txt | grep ' A ' | xargs -i bash -c "proc '{}'"
mkdir -p all_screenshots
find -name "*.png" | grep eyewitness | xargs -n 1 -i cp "{}" all_screenshots/ 2> /dev/null
