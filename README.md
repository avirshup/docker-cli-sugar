# Docker CLI Sugar

A variety of command line tools to help with common docker tasks.

These commands require `bash` _on the host_, but support containers with `bash` and/or just `sh`.

### Install
Requires bash.
```
git clone https://github.com/avirshup/docker-cli-sugar
export PATH=$(pwd)/docker-cli-sugar:${PATH}

# Enable for all your bash sessions:
echo "export PATH=$(pwd)/docker-cli-sugar:${PATH}" >> ~/.bash_profile
```


# The commands

### `dshell [image-or-container-name-or-id]`

Launch a shell in an image or container (whether running or stopped). Launches `bash` by preference, otherwise `sh`.

#### Shell in a running container
```bash
[host]$ docker run -d --name "running-container" alpine sleep 10000
[host]$ dshell running-container
Running 'docker exec  -it running-container [...]'
shell: sh
[container]$ apk update
[...]
```

#### Shell in an image
```bash
[host]$ dshell centos
Running "docker run -it --entrypoint=sh centos"
shell: sh
[container]$ apk update
[...]
```

#### Examining a stopped container

```bash
[host]$ docker run --name "stopped-container" \
             alpine sh -c "echo hello world > hello.txt"
[host]$ dshell stopped-container
Container is stopped. Committing to image
Running "docker commit stopped-container dshell-temp-container"
sha256:[...]
Running "docker run --entrypoint=sh -it dshell-temp-container"
[container]$ ls
hello.txt
[container]$ cat hello.txt
hello world
```

### `drm [images-and-container-ids] [arguments for docker rmi]
Remove images and/or containers

### Example
```bash
[host]$ docker run alpine echo hello world --name removeme
[host]$ drm alpine removeme


### `dps`
Alias for `docker ps`

### `dim`
Alias for `docker images`

### `dstats`
Alias for `docker stats`
