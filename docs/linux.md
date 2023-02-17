# Linux

Tips, tricks, and tutorials for using Linux and its various distributions.

## Debian APT Mirrors

I ran into a strange issue where Debian kept trying to pull from mirrors I never specified like `debian.gtisc.gatech.edu`. Turns out, there is another file where mirrors are stored:

```bash
/usr/share/python-apt/templates/Debian.mirrors
```

## Fix Broken resolv.conf

If you are having issues with DNS resolution, you can try to fix it by running:

!!! warning
    This will only work if you are using systemd-resolved. It will also wipe out any custom DNS servers you have set manually in `/etc/resolv.conf`.

```bash
sudo rm /etc/resolv.conf
sudo ln -sv /run/systemd/resolve/resolv.conf /etc/resolv.conf
```
