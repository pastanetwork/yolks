#!/bin/bash

# Default the TZ environment variable to UTC.
TZ=${TZ:-UTC}
export TZ

# Set environment variable that holds the Internal Docker IP
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

# Switch to the container's working directory
cd /home/container || exit 1

# Print luanti/minetest version
if command -v luanti > /dev/null 2>&1; then
    printf "\033[1m\033[33mroot@pastanetwork:~ \033[0mluanti --version\n"
    luanti --version
else
    printf "\033[1m\033[33mroot@pastanetwork:~ \033[0mminetest --version\n"
    minetest --version
fi

# Replace Startup Variables
MODIFIED_STARTUP=$(echo -e ${STARTUP} | sed -e 's/{{/${/g' -e 's/}}/}/g')
echo -e ":/home/container$ ${MODIFIED_STARTUP}"

# Run the Server
eval ${MODIFIED_STARTUP}
