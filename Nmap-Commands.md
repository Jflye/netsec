Multiple IP Addresses or Subnet
```
nmap 192.168.1.1 192.168.1.2 192.168.1.3
```
Scan a range of IP address:
```
nmap 192.168.1.1-20
```
Scan a range of IP address using a wildcard:
```
nmap 192.168.1.*
```
Scan an entire subnet:
```
nmap 192.168.1.0/24
```
Scan a list of hosts:
```
nmap -iL /tmp/test.txt
```
OS and Version Detection
```
nmap -A 192.168.1.254
nmap -v -A 192.168.1.1
nmap -A -iL /tmp/scanlist.txt
```

Find out if a Host/Network is protected by a firewall:
```
nmap -sA 192.168.1.254
nmap -sA example.com
```
Scan a host when protected by a firewall:
```
nmap -PN 192.168.1.1
nmap -PN example.com
```
Scan IPV6: 
- ("-6" enables IPv6 scanning.)
```
nmap -6 example.com
nmap -6 <IPv6 here>
nmap -v A -6 <IPv6 here>
```
Host discovery/Ping scan:
```
nmap -sP 192.168.1.0/24
```
Fast Scan:
```
nmap -F 192.168.1.1
```
Show only open ports:
```
nmap --open 192.168.1.1
nmap --open example.com
```
Scan Specific Ports:
```
nmap -p [port] hostName
# Scan port 80
nmap -p 80 192.168.1.1
# Scan TCP port 80
nmap -p T:80 192.168.1.1
# Scan UDP port 53
nmap -p U:53 192.168.1.1
# Scan two ports
nmap -p 80,443 192.168.1.1
# Scan port ranges
nmap -p 80-200 192.168.1.1
# Combine all options
nmap -p U:53,111,137,T:21-25,80,139,8080 192.168.1.1
nmap -p U:53,111,137,T:21-25,80,139,8080 example.com
nmap -v -sU -sT -p U:53,111,137,T:21-25,80,139,8080 192.168.1.254
# Scan all ports with * wildcard
nmap -p "*" 192.168.1.1
# Scan top ports i.e. scan $number most common ports
nmap --top-ports 5 192.168.1.1
nmap --top-ports 10 192.168.1.1
```
Fastest way to scan:
```
nmap -T5 192.168.1.0/24
```
Identify remote host apps and OS "-O":
```
nmap -O 192.168.1.1
nmap -O  --osscan-guess 192.168.1.1
nmap -v -O --osscan-guess 192.168.1.1
```
Scan for remote services & Versions:
```
nmap -sV 192.168.1.1
``` 
Bypass firewall ICMP ping scans:
```
nmap -PS 192.168.1.1
nmap -PS 80,21,443 192.168.1.1
nmap -PA 192.168.1.1
nmap -PA 80,21,200-512 192.168.1.1
```
Bypass Firewalls blocking TCP scans with UDP:
```
nmap -PU 192.168.1.1
nmap -PU 2000.2001 192.168.1.1
```
Scan for UDP services:
```
nmap -sU nas03
nmap -sU 192.168.1.1
```
Scan for IP Protocol:
```
nmap -sO 192.168.1.1
```
Save scan results to output file:
```
nmap 192.168.1.1 > output.txt
nmap -oN /path/to/filename 192.168.1.1
nmap -oN output.txt 192.168.1.1
```
Faster scans:
```
nmap -v -sS -A -T4 <or T5> 192.168.2.5
```
