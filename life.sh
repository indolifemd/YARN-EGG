#!/bin/bash

RED='\033[1;31m'
GREEN='\033[1;32m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
YELLOW='\033[1;33m'
MAGENTA='\033[1;35m'
NC='\033[0m'

clear
echo -e "${RED}"
echo "=============================="
echo -e "     ${MAGENTA}Welcome to IndoLife${NC}     "
echo "=============================="
echo -e "${NC}"
sleep 1

echo -e "${CYAN}Docker Image Metadata:${NC}"
echo -e "${GREEN}Version :${NC} $IMAGE_VERSION"
echo -e "${GREEN}Revision:${NC} $IMAGE_REVISION"
echo -e "${GREEN}Created :${NC} $IMAGE_CREATED"
sleep 1

echo -e "${CYAN}Loading system information...${NC}"
sleep 1
for i in {1..5}; do
    echo -n "."
    sleep 0.5
done
echo -e "${NC}\n"

OS=$(lsb_release -d | awk -F'\t' '{print $2}')
IP=$(hostname -I | awk '{print $1}')
CPU=$(grep -m1 'model name' /proc/cpuinfo | awk -F': ' '{print $2}')
RAM=$(awk '/MemTotal/ {printf "%.2f GB", $2/1024/1024}' /proc/meminfo)
DISK=$(df -h / | awk '/\/$/ {print $2}')
TIMEZONE=$(cat /etc/timezone)
DATE=$(date '+%Y-%m-%d %H:%M:%S')

echo -e "${GREEN}Fetching system details...${NC}"
sleep 1
echo -e "${BLUE}OS        : ${CYAN}$OS${NC}"
sleep 0.5
echo -e "${YELLOW}IP Address: ${CYAN}$IP${NC}"
sleep 0.5
echo -e "${MAGENTA}CPU       : ${CYAN}$CPU${NC}"
sleep 0.5
echo -e "${GREEN}RAM       : ${CYAN}$RAM${NC}"
sleep 0.5
echo -e "${YELLOW}SSD       : ${CYAN}$DISK${NC}"
sleep 0.5
echo -e "${MAGENTA}Timezone  : ${CYAN}$TIMEZONE${NC}"
sleep 0.5
echo -e "${CYAN}Date      : ${NC}$DATE"
sleep 1

echo -e "${RED}==============================${NC}"
sleep 1

cd /home/container
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

echo -e "${GREEN}Node.js Version:${NC} $(node -v)"
echo -e "${GREEN}Yarn Version:${NC} $(yarn -v)"
sleep 1

MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo -e "${CYAN}Modified Startup Command:${NC}"
sleep 1
echo ":/home/container$ ${MODIFIED_STARTUP}"

echo -e "${YELLOW}Installing dependencies with Yarn...${NC}"
yarn install

echo -e "${YELLOW}Starting the server with Yarn...${NC}"
sleep 1
eval ${MODIFIED_STARTUP}

exec "$@"
