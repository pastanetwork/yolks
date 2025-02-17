# Default the TZ environment variable to UTC.
TZ=${TZ:-UTC}
export TZ

# Set environment variable that holds the Internal Docker IP
INTERNAL_IP=$(ip route get 1 | awk '{print $(NF-2);exit}')
export INTERNAL_IP

# Switch to the container's working directory
cd /home/container || exit 1

# Print Erlang's version
printf "\033[1m\033[33mroot@pastanetwork:~ \033[0merl -noshell -eval 'erlang:display(erlang:system_info(system_version))' -eval 'init:stop()'\n"
erl -noshell -eval 'erlang:display(erlang:system_info(system_version))' -eval 'init:stop()'

# Convert all of the "{{VARIABLE}}" parts of the command into the expected shell
# variable format of "${VARIABLE}" before evaluating the string and automatically
# replacing the values.
PARSED=$(echo "$STARTUP" | sed -e 's/{{/${/g' -e 's/}}/}/g')

# Display the command we're running in the output, and then execute it with eval
printf "\033[1m\033[33mroot@pastanetwork:~ \033[0m"
echo "$PARSED"
# shellcheck disable=SC2086
eval "$PARSED"
