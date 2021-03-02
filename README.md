# Patch 001

In the terminal(SSH) enter the following command to apply the patch:
```
bash <(curl -Ls https://raw.githubusercontent.com/teknoir/sustayn_os_patch_001/main/bootstrap.sh)
```

And reboot:
```
sudo reboot
```

## Troubleshooting
The patch in itself is idempotent, so if it would be interrupted it can be run again and it should end up in the correct state.

But, if there is repeated problems executing this long operation, due to terminal session being interrupted. The
patch can be run inside a screen session.

To install screen:
```
apt-get install -y screen
```

Start, or reconnect to, the screen session:
```
screen -R patch001
```

Then run the patch inside the screen session, and it will continue to run even if the terminal connection is broken.
You can go back and reattach to the session with the same command to see it continue and see if it was successfully applied.


## Edit
The path is idempotent and has had tings added to it over time. The "mini" patch is no longer needed.
If called it will run the normal patch to apply the full fix.


### The obsolete mini Patch 001.1

We missed some settings for the ethernet interface and some nvidia drivers, the patch above is also patched to include this patch.
If the patch above is run from now on there should be no reason to use this mini patch 

> This patch fix the eth0 interface settings and enable it to connect to the Axis camera.

In the terminal(SSH) enter the following command to apply the patch:
```
bash <(curl -Ls https://raw.githubusercontent.com/teknoir/sustayn_os_patch_001/main/mini_patch_001.1.sh)
```

And reboot:
```
sudo reboot
```