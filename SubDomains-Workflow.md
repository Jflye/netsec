## subfinder ##
```
docker run --rm -it -v $HOME/.config/subfinder:/root/.config/subfinder subfinder -d example.com \
--timeout 15 -t 10 -nW -r 8.8.8.8,1.1.1.1 > finds.txt
```

## Check lines of subdomains ## 
```
wc -l finds.txt
```
## Delete excessive lines in finds.txt
```
nano finds.txt --> delete the top row...
```

## Nmap (Optional) ##
```
nmap -T5 -R --dns-servers 8.8.8.8,1.1.1.1 -Pn -sV -n -iL finds.txt \
-oX output.xml
```
## Aquatone ##
```
sudo docker run --rm -it -v /home/USER/FOLDER/TARGET.txt:/tmp/targets -v  \
`pwd`:/tmp/results aquatone -scan-timeout 50000 -http-timeout 6000 -threads 20 -ports large
```
## Get rights to Screenshots ##
```
sudo chown -R user:user /home/user/aquatone/screenshots



