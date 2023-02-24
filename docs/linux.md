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

## Linux Disown

The `disown` command is used to remove a job from the current shell's list of jobs. This is useful if you want to run a command in the background and then exit the shell without killing the process.

### Disown Running Application

Here is an example of how to use `disown`:

1. Start a long-running command in the terminal, such as:

    ```bash
    sleep 1000 &
    ```

    This will start a `sleep` command that will run for 1000 seconds (a little over 16 minutes).

2. Press `CTRL-Z` to pause the command and return to the shell prompt.

3. Run the `jobs` command to see the list of jobs that are currently running or paused:

    ```bash
    $ jobs
        [1]+  Stopped                 sleep 1000`
    ```

    The output shows that there is one job running (`sleep 1000`) and it is currently stopped (paused).

4. Run the `disown` command followed by the job number (which is `1` in this case):

    ```bash
    disown %1
    ```

    This will detach the `sleep` command from the shell session and prevent it from being terminated when the shell session is closed.

5. To confirm that the job is no longer being tracked by the shell, run the `jobs` command again:

    ```bash
    jobs
    ```

    There should be no output because there are no jobs being tracked by the shell.

At this point, you can safely close the terminal or log out of the system without worrying about the `sleep` command being terminated. The `sleep` command will continue running in the background until it completes or is terminated by some other means.

### Find Running Application After Linux Disown

To find a running application that has been disowned in Linux, you can use the `pgrep` command along with the name of the application.

Here is an example command:

```bash
pgrep <application_name>
```

Replace `<application_name>` with the name of the application you want to find. This command will return the process ID (PID) of the application if it is currently running.

Alternatively, you can use the `ps` command to find the running application along with its associated processes. Here is an example command:

```bash
ps aux | grep <application_name>
```

Replace `<application_name>` with the name of the application you want to find. This command will display a list of processes that match the specified application name. The first column of the output will be the PID of the running application.