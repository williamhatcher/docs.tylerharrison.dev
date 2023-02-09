# Docker

Collection of useful Docker commands and utilities. Learn all about Docker, from the basics to advanced topics.

## Automated Install Script

```bash
apt update; \
apt install curl; \
curl -fsSL https://get.docker.com -o get-docker.sh; \
chmod +x ./get-docker.sh; \
./get-docker.sh
```

## Composerize

Convert Docker run commands to `docker-compose.yml` files

- Third-party host: [https://www.composerize.com/](https://www.composerize.com/)
- My backup: [https://github.com/tyleraharrison/composerize](https://github.com/tyleraharrison/composerize)
