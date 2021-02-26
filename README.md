# Patch 001

In the terminal(SSH) enter the following command to apply the patch:
```
bash <(curl -Ls https://raw.githubusercontent.com/teknoir/sustayn_os_patch_001/main/bootstrap.sh)
```

And reboot:
```
sudo reboot
```

# Mini Patch 001.1

We missed some settings for the ethernet interface, the patch above is also patched to include this patch.
If the patch above is run from now on there should be no reason to use this mini patch 

> This patch fix the eth0 interface settings and enable it to connect to the Axis camera.

In the terminal(SSH) enter the following command to apply the patch:
```
bash <(curl -Ls https://raw.githubusercontent.com/teknoir/sustayn_os_patch_001/main/mini_patch_001.1.sh)
```

You do not have to reboot the device.