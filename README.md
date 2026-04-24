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

## ⚙️ Commands

After installation:

```bash
startkde-x11     # Starts KDE Plasma on Termux:X11
stopkde-x11      # Stops KDE Plasma on Termux:X11
ubuntu           # Starts Ubuntu shell environment

## Commands to install 


```bash

pkg update
pkg install git
git clone https://github.com/AppNotFound/kde-termux-installer
## If the above command doesn't work try:
git clone https://github.com/AppNotFound/kde-termux-installer-
## Then:
cd kde-termux-installer 
bash setup.sh
