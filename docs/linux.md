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

## KDE Gnome-like Screenshots

If you are using KDE and want to take screenshots like you would in Gnome (i.e. select a region to screenshot and it will automatically copy to clipboard), you can install `flameshot` and then set the following in System Settings > Workspace > Shortcuts > Add Command:

I used the following command: `flameshot gui -c` for `Take Screenshot (Copy to Clipboard)`

You can also use the following commands:

### Save to File

- `flameshot gui -p ~/Pictures/Screenshots` for `Take Screenshot`
- `flameshot full -p ~/Pictures/Screenshots` for `Take Screenshot (Full Screen)`
- `flameshot screen -p ~/Pictures/Screenshots` for `Take Screenshot (Current Screen)`

### Copy to Clipboard

- `flameshot gui -c` for `Take Screenshot (Copy to Clipboard)`
- `flameshot full -c` for `Take Screenshot (Full Screen) (Copy to Clipboard)`
- `flameshot screen -c` for `Take Screenshot (Current Screen) (Copy to Clipboard)`
