#!/bin/sh
# daemon script - Restarts the daemon if it stops syncing

# get the block height
block_height=$(curl -X POST http://127.0.0.1:18281/json_rpc --data '{"jsonrpc":"2.0","id":"0","method":"get_block_count"}' -H 'Content-Type: application/json' | grep count | cut -b 14- | sed 's/.$//' | sed 's/.$//')

# get the current block height and block height from the explorer
current_block_height=$(curl -X GET https://explorer.x-cash.org/getcurrentblockheight | cut -b 17- | sed 's/.$//')
block_height_result=$((current_block_height - block_height))

# error check
if [ -z $current_block_height ] || [ -z $block_height_result]
then
exit 0
fi

# check if their is an error
if [ $block_height_result -lt -2 ] || [ $block_height_result -gt 2 ]
then
screen -XS Daemon quit && sleep 60s && screen -dmS Daemon PATH_TO_XCASHD_BINARY
fi
