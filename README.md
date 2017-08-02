# Teeworlds server

# Usage

## Building your own

```bash
docker build --tag=teeworlds:latest .
```

```bash
docker run --rm -p 8303:8303/udp -v $PWD/serverconfig.cfg:/usr/local/teeworlds/serverconfig.cfg teeworlds:latest
```

## Use the docker HUB image

```bash
git clone https://github.com/mathieupotier/teeworld_server_docker.git
cd teeworld_server_docker
docker run --rm -p 8303:8303/udp -v $PWD/serverconfig.cfg:/usr/local/teeworlds/serverconfig.cfg mathieupotier/teeworld_server_docker:latest
```
