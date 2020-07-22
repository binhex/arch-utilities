**Application**

[Arch Linux](https://www.archlinux.org/)

**Description**

Arch Linux is an independently developed, i686/x86-64 general purpose GNU/Linux distribution versatile enough to suit any role. Development focuses on simplicity, minimalism, and code elegance.

**Build notes**

Arch Linux utilities image using "arch-base" image from the [binhex repository](https://hub.docker.com/r/binhex/arch-base/). This image is set to a snapshot by using the archive.archlinux.org website for package updates, this is required to reduce image size by preventing continual updates to packages.

**Notes**

This image is primarily used to run various utilities on Linux platforms. This Docker image includes the following packages:-

- supervisor (process manager)
- screen
- rclone
- youtube-dl
- stress
- tcpdump
- dos2unix
- tmux

If you appreciate my work, then please consider buying me a beer  :D

[![PayPal donation](https://www.paypal.com/en_US/i/btn/btn_donate_SM.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=MM5E27UX6AUU4)

[Documentation](https://github.com/binhex/documentation)