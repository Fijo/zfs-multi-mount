# zfs-multi-mount
Mounts several ZFS datasets while asking for encryption passphrase as rarely as possible. If the same encryption passphrase is used on several datasets, it will ask once. For people who feel very confident about that one passphrase.

I generally do not endorse reusing passwords, but there are edge cases, like splitting up a pool into datasets while not using an encryption root due to some topology constraint, but still needing the convenience of a single passphrase.

This script can be used in a systemd service to unlock encrypted datasets during boot. Practical if using several datasets with the same passphrase.

## Usage
### Load keys of all datasets and mount them
`zfs-multi-mount.sh`

### Load keys for specific datasets and mount them
`zfs-multi-mount.sh pool/dataset1 pool/dataset2 pool/dataset3`

### Load keys without mounting the datasets
`zfs-multi-mount.sh --no-mount`

### Use within systemd context (in a systemd service)
`zfs-multi-mount.sh --systemd`

### Install as systemd service
```bash
sudo sh ./install.sh
```

### Missing zpools
For me this service used to not unlock the datasets on my second zpool.

It seams the issue was that, this zpool was never imported manually at such an early booting stage.
Afterwards it the auto import/ mount/ unlock worked flawlessly!

This is how I recommend performing this one time manual zpool import:
1. Open the `/usr/local/sbin/zfs-load-key.service` in a text editor.
2. Go to the line starting with `ExecStart`
3. Add an extra argument containing the name of the zpool, you are missing at the end.
   It will then try to load that zpools root dataset on the next boot.
   Due to the fact, that it's not importet it will not be found and fail, giving you the option to drop into a root shell for troubleshooting.
4. Reboot and get into that troubleshooting shell.
5. Run `zpool import <myPoolName>`
6. Undo the changes you made to `/usr/local/sbin/zfs-multi-mount.sh` again.
7. Manually run `/usr/local/sbin/zfs-multi-mount.sh --systemd --no-mount` for your curiosity.
8. Reboot again.

## Credit
Created and maintained by Pawel Ginalski (https://gbyte.dev).
Updated by Jonas Fischer (https://fijo.dev)
