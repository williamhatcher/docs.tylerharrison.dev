# Proxmox

## Installation

TODO: Add installation instructions

## Tips/Tricks

### USB Passthrough

#### VM (Virtual Machines)

1. Go to the Proxmox web interface and click on your VM.
2. Click on the `Hardware` tab.
3. Click on the `Add` button and select `USB Device`.
4. Select the USB device you want to passthrough and click `OK`.
5. Click on the `Save` button.

If you are using a USB device that is not recognized by the VM, you may need to instead pass the whole USB controller to the VM. To do this, follow the steps above, but instead of selecting a specific USB device, select the USB controller.

#### LXC (Linux Containers)

1. Go to the Proxmox web interface and click on the node that your LXC is on.
2. Click on the `Shell` button.
3. Run the following command to get a list of your USB devices:

    ```bash
    lsusb
    ```

    Example output:

    ```bash
    Bus 001 Device 007: ID 1a86:55d4 QinHeng Electronics SONOFF Zigbee 3.0 USB Dongle Plus V2
    ```

    Take note of the `Bus` and `Device` IDs for the devices you want to passthrough.
    You should also run the following command to get a list of the USB device mounts:

    ```bash
    ls -l /dev/serial/by-id
    ```

    Example output:

    ```bash
    total 0
    lrwxrwxrwx 1 root root 13 Mar 27 18:18 usb-ITEAD_SONOFF_Zigbee_3.0_USB_Dongle_Plus_V2_20221202210759-if00 -> ../../ttyACM0
    ```

    If you have a similar output to `../../ttyACM0`, you can use the `ttyACM0` value as the `Device` ID in the next step. If you have a different output, you will need to use the `Bus` and `Device` IDs from the previous step.

4. Get the major and minor numbers for the USB device:

    ```bash
    ls -al /dev/bus/usb/(Bus ID)/(Device ID)
    ```

    Example output:

    ```bash
    crw-rw-rw- 1 root root 189, 6 Mar 27 18:18 /dev/bus/usb/001/007
    ```

    The major and minor numbers are `189` and `6` in this example.

5. Using the `Container ID` you took note of earlier, run the following command to get a list of the USB devices that are currently attached to the LXC:

    ```bash
    nano /etc/pve/lxc/<Container ID>.conf
    ```

    If you are using Alpine, you may need to install `nano` first:

    ```bash
    apk add nano
    ```

    Insert the following lines into the file:

    ```bash
    lxc.cgroup.devices.allow: c 189:* rwm
    lxc.mount.entry: /dev/ttyACM0 dev/ttyACM0 none bind,optional,create=file none bind,optional,create=file

    ```

    If you have a similar output to `../../ttyACM0` in the previous step, you can use the `ttyACM0` method. Alternatively, you must use:

    ```bash
    lxc.cgroup.devices.allow: c 189:* rwm
    lxc.mount.entry: /dev/bus/usb/001/007 dev/bus/usb/001/007 none bind,optional,create=file
    ```

    Replace the `189` with the major number you got in the previous step. Replace the `001` and `007` with the `Bus` and `Device` IDs you got in the previous step.

    Save and exit the file.

6. Restart the LXC

If you have any issues with the USB device not being recognized like I did, you can try the following on the host:

```bash
chmod a+rwx /dev/ttyACM0
```

or if you are using the `Bus` and `Device` IDs:

```bash
chmod a+rwx /dev/bus/usb/001/007
```

I am almost certain that this is not the correct way to do this, but it worked for me.
