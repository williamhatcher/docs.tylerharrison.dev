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
    apk add openrc; \
    apk add docker docker-cli-compose; \
    rc-update add docker default; \
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

## Kasm Workspaces

Kasm Workspaces is a web-based Docker management tool. It allows you to manage your Docker containers, images, volumes, networks and more! Kasm Workspaces is meant to be as simple to deploy as it is to use. It consists of a single container that can run on any Docker engine (Docker for Linux and Docker for Windows are supported).

### Install

    cd /tmp; \
    curl -O https://kasm-static-content.s3.amazonaws.com/kasm_release_1.12.0.d4fd8a.tar.gz; \
    tar -xf kasm_release_1.12.0.d4fd8a.tar.gz; \
    sudo bash kasm_release/install.sh; \

### Uninstall

    sudo /opt/kasm/current/bin/stop; \
    sudo docker rm -f $(sudo docker container ls -qa --filter="label=kasm.kasmid"); \
    export KASM_UID=$(id kasm -u); \
    export KASM_GID=$(id kasm -g); \
    sudo -E docker compose -f /opt/kasm/current/docker/docker-compose.yaml rm; \
    sudo docker network rm kasm_default_network; \
    sudo docker volume rm kasm_db_1.12.0; \
    sudo docker rmi redis:5-alpine; \
    sudo docker rmi postgres:9.5-alpine; \
    sudo docker rmi kasmweb/nginx:latest; \
    sudo docker rmi kasmweb/share:1.12.0; \
    sudo docker rmi kasmweb/agent:1.12.0; \
    sudo docker rmi kasmweb/manager:1.12.0; \
    sudo docker rmi kasmweb/api:1.12.0; \

    sudo docker rmi $(sudo docker images --filter "label=com.kasmweb.image=true" -q); \
    sudo rm -rf /opt/kasm/; \
    sudo userdel kasm_db -r; \
    sudo userdel kasm -r;
