cent_mirror_vm
==============

This is a vagrant VM running centos. Its sole mission is to mirror yum repositories and serve them up. There are a few things which are not baked in to the logic - gnupg key file mirroring. Worst case your VMs will still pull those down but it should be a one time deal per repo for that VM.

Any .repo files you would want on a guest go in remote_repo_files.

There is a cron job which runs daily at 23:59GMT to keep your mirrors synced up. If you do not want this behavior, log in to the VM and enter `crontab -d` to remove the crontab.
