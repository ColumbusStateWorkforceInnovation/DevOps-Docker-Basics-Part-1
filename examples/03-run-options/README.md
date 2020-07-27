# More docker run options

Since `docker run` is the main entry point into running containers, let's see what other useful options there are.

## Auto-remove

A very helpful option to avoid clutter is to use the `--rm` flag, which will automatically remove the container when it is exited.

```
[jschmersal1@WFIL011 examples]$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
[jschmersal1@WFIL011 examples]$ docker run --rm --name blah -d httpd
d60e115574701dd8b76b69c88e5099f30ae67ee89eaecfc1be3f05bb1c40556d
[jschmersal1@WFIL011 examples]$ docker ps
CONTAINER ID        IMAGE               COMMAND              CREATED             STATUS              PORTS               NAMES
d60e11557470        httpd               "httpd-foreground"   3 seconds ago       Up 2 seconds        80/tcp              blah
[jschmersal1@WFIL011 examples]$ docker stop blah
blah
[jschmersal1@WFIL011 examples]$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
```

## Port mapping
Many docker usecases involve running a server or an application that listens on an internet port (e.g. web applications listening on the http port, port 80, or on https port, port 443).  Most images specify that servers running in containers started from that image should listen on a particular port.  However, by default that server process is only listening on the given port within the container (this is for both security and to avoid cross-container conflicts - e.g. two applications both wanting to listen on port 80).

Port mapping creates a "tunnel" from the host into the container, so that the specified port on the host maps to the corresponding port internally.  To achieve this, you use the `-p` option (or `--expose`) to `docker run`. The format of the argument to `-p` is `<host port specification>:<container port specification>`.  For example, to have httpd listen on port 4141, try running: `docker run --rm --name apache -p 4141:80 httpd:2.4`

```
[jschmersal1@WFIL011 examples]$ docker run --rm --name apache -p 4141:80 httpd:2.4
Unable to find image 'httpd:2.4' locally
2.4: Pulling from library/httpd
Digest: sha256:2a9ae199b5efc3e818cdb41c790638fc043ffe1aba6bc61ada28ab6356d044c6
Status: Downloaded newer image for httpd:2.4
AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 172.17.0.2. Set the 'ServerName' directive globally to suppress this message
AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 172.17.0.2. Set the 'ServerName' directive globally to suppress this message
[Mon Jul 27 19:48:19.747210 2020] [mpm_event:notice] [pid 1:tid 140160155866240] AH00489: Apache/2.4.43 (Unix) configured -- resuming normal operations
[Mon Jul 27 19:48:19.747409 2020] [core:notice] [pid 1:tid 140160155866240] AH00094: Command line: 'httpd -D FOREGROUND'
172.17.0.1 - - [27/Jul/2020:19:48:53 +0000] "GET / HTTP/1.1" 200 45
172.17.0.1 - - [27/Jul/2020:19:48:53 +0000] "GET /favicon.ico HTTP/1.1" 404 196
```

Navigate your browser to [http://localhost:4141](http://localhost:4141) to see the generic "It works!" httpd home page.  Port mapping can be more specific and complicated, and you can pass multiple `-p` options to `docker run` to map multiple ports.

## STDIN, and TTY allocation
The concept of STDIN should be familiar to you (it's what a process reads data from).  The use of STDIN and TTYs in a docker context can be a bit confusing, but at a high level, if you want to be able to interact with your container, with it reading textual content that you send to it through your terminal, you will frequently have to pass the `-it` options to `docker run`.

In this example, let's run a quick ruby interactive shell:

```
[jschmersal1@WFIL011 examples]$ docker run -it --name ruby-shell ruby:2
irb(main):001:0> 1+1
=> 2
irb(main):002:0> puts "Hello World!"
Hello World!
=> nil
```

Notice that I can type input in my terminal that the ruby container running can read and interpret, and the results show up on my terminal.  The `-i` (STDIN, or interactive) flag lets the ruby process in the container read from my terminal, and the `-t` (attach a TTY) flag lets the ruby process write out to my terminal.

Server processes rarely need the `-it` flags, but ad hoc docker containers frequently do.

## Environment Variables
Docker containers are frequently passed configuration information through environment variables.  To pass an environment variable into the container, use the `-e` (or ) option with `docker run`.  For example, `docker run --name blah --rm -e HAPPY=true ubuntu env`
```
[jschmersal1@WFIL011 examples]$ docker run --name blah --rm -e HAPPY=true ubuntu env
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOSTNAME=ace4dacd9c72
HAPPY=true
HOME=/root
```

Whereas if I run without that environment variable:
```
[jschmersal1@WFIL011 examples]$ docker run --name blah --rm  ubuntu env
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOSTNAME=9ac4e601e7be
HOME=/root
```

Note that you can implicitly pass through the values of environment variables already defined in your shell:
```
[jschmersal1@WFIL011 examples]$ export COLOR=brown
[jschmersal1@WFIL011 examples]$ docker run --name blah --rm -e COLOR ubuntu env
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOSTNAME=285fc8105746
COLOR=brown
HOME=/root
[jschmersal1@WFIL011 examples]$ unset COLOR
[jschmersal1@WFIL011 examples]$ docker run --name blah --rm -e COLOR ubuntu env
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOSTNAME=8577988488d2
HOME=/root
```

 
