# KDE Plasma on Termux (X11 Setup)

This project provides scripts to run and control KDE Plasma desktop environment on Termux using Ubuntu and X11.

---

## 🚀 Features

- One-command KDE start
- One-command KDE stop
- Ubuntu-based environment
- Lightweight X11 desktop support
- Easy automation for mobile Linux setup

---

## Requirements

1) Minimum 2GB RAM
2) Minimum 8GB storage 
3) Android 8 or higher
4) Termux and Termux:X11 installed

install Termux from:
https://github.com/termux/termux-app/releases/download/v0.118.3/termux-app_v0.118.3+github-debug_arm64-v8a.apk

install Termux:X11 from:

https://github.com/termux/termux-x11/releases/download/nightly/app-arm64-v8a-debug.apk


## ⚙️ Commands

After installation:

```bash
startkde-x11     # Starts KDE Plasma on Termux:X11
stopkde-x11      # Stops KDE Plasma on Termux:X11
ubuntu           # Starts Ubuntu shell environment

## Commands to install 

pkg update
pkg install git
git clone https://github.com/AppNotFound/kde-termux-installer.git
## If the above command doesn't work try:
git clone https://github.com/AppNotFound/kde-termux-installer-.git
## Then:
cd kde-termux-installer 
bash setup.sh
