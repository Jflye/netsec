## subfinder ##
```
docker run --rm -it -v $HOME/.config/subfinder:/root/.config/subfinder subfinder -d example.com \
--timeout 15 -t 10 -nW -r 8.8.8.8,1.1.1.1 > finds.txt

## Nmap ##
nmap -T5 -R --dns-servers 8.8.8.8,1.1.1.1 -Pn -sV -n -iL finds.txt \
-oX forescout-nmap2.xml

## Aquatone ##
docker run --rm -it -v /home/monk/Docker/dockero-infosec/subfinder/output.xml:/tmp/targets -v \
`pwd`:/tmp/results aquatone -scan-timeout 50000 -http-timeout 6000 -threads 20 -ports large

## Get rights to Screenshots ##
sudo chown -R /home/user/aquatone/screenshots
