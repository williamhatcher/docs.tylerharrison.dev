# Home Assistant

A comprehensive guide to the popular home automation platform.

## Installation

My preferred way to install Home Assistant is on a Proxmox LXC rather than a VM. This is because Proxmox LXC containers are much lighter weight than VMs and they are much easier to manage.

The following guide assumes you have a Proxmox server already setup. If you do not, refer to the [Proxmox](./proxmox.md) guide.

This guide will walk you through creating an LXC container and installing Home Assistant on it. It will also show you how to passthrough USB devices to the LXC container, such as a Z-Wave stick or Zigbee USB dongle.

### Create LXC

If you already have an LXC and you're just trying to figure out the way to passthrough your USB devices, skip to the next section.

1. Create a new LXC container with the following settings:
   - Name: `home-assistant`
   - Template: `local:vztmpl/alpine-...` (latest Alpine or Debian template)
   - Storage: `local-lvm`
   - Rootfs: `local-lvm:vm-100-disk-1`
   - Network: `vmbr0`
   - IP Address: `DHCP`
2. Don't start the container yet. Take note of the `Container ID` (usually a 3 digit number). You will need it later.

### Passthrough USB Devices (optional)

Refer to the [USB Passthrough](./proxmox.md#usb-passthrough) guide for more information.

### Setup Home Assistant

To make things easier, we will be using Docker and Docker Compose to install Home Assistant. This will also make it easier to update Home Assistant in the future.

1. Start the LXC container.
2. Install Docker and Docker Compose using the commands linked [here](../docker.md#automated-install-script).
3. Create a new directory for Home Assistant:

    ```bash
    mkdir home-assistant
    ```

4. Create a new file called `docker-compose.yml` in the `home-assistant` directory:

    ```bash
    nano docker-compose.yml
    ```

5. Copy the following into the file:

    ```yaml
    version: '3.3'
    services:
        home-assistant:
            restart: always
            container_name: homeassistant
            volumes:
                - home_assistant_config:/config
                - /etc/localtime:/etc/localtime:ro
            # Uncomment the following lines if you have USB
            # devices:
            #     - /dev/ttyACM0:/dev/ttyACM0
            environment:
                - TZ=America/Chicago
            network_mode: host
            image: 'ghcr.io/home-assistant/home-assistant:stable'
    volumes:
        home_assistant_config:
            name: 'home_assistant_config'
    ```

    Replace the `America/Chicago` with your timezone.

    If you have USB devices to passthrough, uncomment the commented out section. Replace the `/dev/ttyACM0` with the device you want to passthrough. If you have a similar output to `../../ttyACM0` in the previous step, you can use the `ttyACM0` method. Alternatively, you must use the same bus and device IDs you used in the previous step (e.g. `/dev/bus/usb/001/007`). You can also add multiple devices to the list.

6. Save and exit the file.
7. Run the following command to start Home Assistant:

    ```bash
    docker-compose up -d
    ```

8. Open your browser and go to `http://<IP Address>:8123`. Replace `<IP Address>` with the IP address of your LXC container. You can find this by running the following command:

    ```bash
    ip addr show
    ```

    Example output:

    ```bash
    2: eth0@if3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default qlen 1000
        link/ether 00:16:3e:xx:xx:xx brd ff:ff:ff:ff:ff:ff link-netnsid 0
        inet
    ```

    The IP address is the `inet` value.

9. Follow the instructions to complete the setup.
