# nginx-lua-monitor
NGINX monitoring with Lua

This module collect information for each virtual server that created in NGINX.

Information data:
- Number of all requests to domain
- Number of requests to backend server
- Number of ajax requests
- Number of bad requests like 400, 449, 408, 444
- Number of sent bytes to client or counting traffic

Example of output:
```localhost;all;100
localhost;backend;100
localhost;banned;0
localhost;ajax;0
localhost;bytes;156
site.com;all;234
site.com;backend;100
site.com;banned;4
site.com;ajax;120
site.com;bytes;5431
```

There is also support output in JSON format.
