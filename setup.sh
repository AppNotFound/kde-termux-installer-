#!/data/data/com.termux/files/usr/bin/bash

# Colors
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
RESET='\033[0m'

clear

echo -e "${CYAN}======================================${RESET}"
echo -e "${CYAN}   KDE on Termux (X11) Setup Script${RESET}"
echo -e "${CYAN}======================================${RESET}"
echo ""

# STEP 1
echo -e "${BLUE}[1/6] Updating Termux...${RESET}"
pkg update -y && pkg upgrade -y
echo -e "${GREEN}✔ Termux updated${RESET}\n"

# STEP 2
echo -e "${BLUE}[2/6] Installing proot-distro...${RESET}"
pkg install -y proot-distro
echo -e "${GREEN}✔ proot-distro installed${RESET}\n"

# STEP 3
echo -e "${BLUE}[3/6] Installing Ubuntu...${RESET}"
proot-distro install ubuntu
echo -e "${GREEN}✔ Ubuntu installed${RESET}\n"

# STEP 4
echo -e "${BLUE}[4/6] Installing KDE inside Ubuntu...${RESET}"

proot-distro login ubuntu --shared-tmp <<EOF

echo -e "${YELLOW}Updating Ubuntu...${RESET}"
apt update && apt upgrade -y

echo -e "${YELLOW}Installing KDE (minimal)...${RESET}"
apt install -y kde-plasma-desktop --no-install-recommends

echo -e "${YELLOW}Installing required fixes...${RESET}"
apt install -y plasma-session-x11 dbus-x11

echo -e "${YELLOW}Installing apps...${RESET}"
apt install -y konsole dolphin firefox --no-install-recommends

apt clean

EOF

echo -e "${GREEN}✔ KDE installed${RESET}\n"

# STEP 5
echo -e "${BLUE}[5/6] Installing Termux:X11...${RESET}"
pkg install -y x11-repo
pkg install -y termux-x11-nightly dbus
echo -e "${GREEN}✔ Termux:X11 installed${RESET}\n"

# STEP 6
echo -e "${BLUE}[6/6] Creating commands...${RESET}"

# startkde-x11
cat > $PREFIX/bin/startkde-x11 <<'SCRIPT'
#!/data/data/com.termux/files/usr/bin/bash

RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
RESET='\033[0m'

clear

echo -e "${CYAN}======================================${RESET}"
echo -e "${CYAN}   Starting KDE Plasma (X11)${RESET}"
echo -e "${CYAN}======================================${RESET}"

pkill -f termux-x11 2>/dev/null
pkill -f startplasma-x11 2>/dev/null

echo -e "${BLUE}[1/3] Starting Termux:X11...${RESET}"
termux-x11 :1 &
sleep 3

echo -e "${BLUE}[2/3] Entering Ubuntu...${RESET}"
echo -e "${BLUE}[3/3] Launching KDE...${RESET}"
am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity

proot-distro login ubuntu --shared-tmp <<EOF

export DISPLAY=:1
export XDG_RUNTIME_DIR=/tmp/runtime-root
mkdir -p \$XDG_RUNTIME_DIR

dbus-launch --exit-with-session startplasma-x11

EOF
SCRIPT

# stopkde-x11
cat > $PREFIX/bin/stopkde-x11 <<'SCRIPT'
#!/data/data/com.termux/files/usr/bin/bash

RED='\033[1;31m'
GREEN='\033[1;32m'
CYAN='\033[1;36m'
RESET='\033[0m'

clear

echo -e "${CYAN}======================================${RESET}"
echo -e "${CYAN}   Stopping KDE Plasma${RESET}"
echo -e "${CYAN}======================================${RESET}"

pkill -f startplasma-x11 2>/dev/null
pkill -f termux-x11 2>/dev/null

echo -e "${GREEN}✔ KDE stopped successfully${RESET}"
SCRIPT

# ubuntu command
cat > $PREFIX/bin/ubuntu <<'SCRIPT'
#!/data/data/com.termux/files/usr/bin/bash

CYAN='\033[1;36m'
RESET='\033[0m'

clear
echo -e "${CYAN}Entering Ubuntu shell...${RESET}"

proot-distro login ubuntu --shared-tmp
SCRIPT

chmod +x $PREFIX/bin/startkde-x11
chmod +x $PREFIX/bin/stopkde-x11
chmod +x $PREFIX/bin/ubuntu

echo ""
echo -e "${CYAN}======================================${RESET}"
echo -e "${GREEN}        SETUP COMPLETED 🎉${RESET}"
echo -e "${CYAN}======================================${RESET}"
echo ""
echo -e "${YELLOW}Commands:${RESET}"
echo -e "${GREEN}  startkde-x11${RESET} → Start KDE"
echo -e "${GREEN}  stopkde-x11 ${RESET} → Stop KDE"
echo -e "${GREEN}  ubuntu      ${RESET} → Open Ubuntu shell"
echo ""
