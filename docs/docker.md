# Docker

Collection of useful Docker commands and utilities. Learn all about Docker, from the basics to advanced topics.

## Automated Install Script

=== "Debian"

    ```bash
    apt update; \
    apt install curl; \
    curl -fsSL https://get.docker.com -o get-docker.sh; \
    chmod +x ./get-docker.sh; \
    ./get-docker.sh
    ```

=== "Ubuntu"

    ```bash
    sudo apt update; \
    sudo apt install curl; \
    curl -fsSL https://get.docker.com -o get-docker.sh; \
    chmod +x ./get-docker.sh; \
    sudo ./get-docker.sh
    ```

=== "Fedora/RHEL"

    ```bash
    sudo dnf update; \
    sudo dnf install curl; \
    curl -fsSL https://get.docker.com -o get-docker.sh; \
    chmod +x ./get-docker.sh; \
    sudo ./get-docker.sh
    ```

=== "Arch"

    ```bash
    sudo pacman -Syu; \
    sudo pacman -S docker; \
    sudo systemctl start docker; \
    sudo systemctl enable docker
    sudo usermod -aG docker $USER
    ```

=== "Alpine"

    ```bash
    echo "http://ftp.halifax.rwth-aachen.de/alpine/v3.16/main" >> /etc/apk/repositories; \
    echo "http://ftp.halifax.rwth-aachen.de/alpine/v3.16/community" >> /etc/apk/repositories; \
    apk update; \
    apk add docker docker-cli-compose; \
    rc-update add dockerboot; \
    service docker start
    ```

## Portainer

Portainer is a web-based Docker management tool. It allows you to manage your Docker containers, images, volumes, networks and more! Portainer is meant to be as simple to deploy as it is to use. It consists of a single container that can run on any Docker engine (Docker for Linux and Docker for Windows are supported).

### Install/Uninstall

Install:

    docker volume create portainer_data; \
    docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest

Uninstall:

    docker stop portainer; \
    docker rm portainer; \
    docker volume rm portainer_data

### Misc Notes

- Disable "Use SSO" if using Authentik

## Composerize

Convert Docker run commands to `docker-compose.yml` files

- Third-party host: [https://www.composerize.com/](https://www.composerize.com/)
- My backup: [https://github.com/tyleraharrison/composerize](https://github.com/tyleraharrison/composerize)
