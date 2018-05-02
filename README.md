# Docker CLI Sugar

A variety of command line tools to help with common docker tasks.

These commands require `bash` _on the host_, but support containers with `bash` and/or just `sh`.


## The commands

### d-shell

Launch a shell in an image or container (whether running or stopped). Launches `bash` by preference, otherwise `sh`.

#### Example: shell in a running container
```bash
[host]$ docker run -d --name "running-container" alpine sleep 10000
[host]$ d-shell running-container
Running "docker exec -it running-container sh"
[container]$ apk update
[...]
```

#### Example: shell in an image
```bash
[host]$ d-shell alpine
Running "docker run -it --entrypoint=sh alpine"
[container]$ apk update
[...]
```

#### Example: examining a stopped container

```bash
[host]$ docker run --name "stopped-container" \
             alpine sh -c "echo hello world > hello.txt"
[host]$ d-shell stopped-container
Container is stopped. Committing to image
Running "docker commit stopped-container d-shell-temp-container"
sha256:[...]
Running "docker run --entrypoint=sh -it d-shell-temp-container"
[container]$ ls
hello.txt
[container]$ cat hello.txt
hello world
```

