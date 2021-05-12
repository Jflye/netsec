### Fuzz parameter with wfuzz

```
sudo docker run --rm -it -v $list:/x wfuzz -w /x  --hc 404,403 --hh 16 -d "FUZZ=1" -t 50 https://example.com/FUZZ
```
