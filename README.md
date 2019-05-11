# X-CASH Proof of stake scripts

These scripts are for maintencing a delegate.

restart_daemon - Script to restart the daemon if it stops syncing

## Installation

### Restart Daemon Script

First make sure the script is executable by running a terminal in the same folder as the script and running  
`chmod +x restart_daemon.sh`

Next, change this line in the script `screen -XS Daemon quit && sleep 60s && screen -dmS Daemon PATH_TO_XCASHD_BINARY` to the full path that the xcashd file is located in. Make sure to add any flags you want to the daemon at the end of the command.  

For example a server running as the user of username storing the blockchain file in /home/username/X-CASH_blockchain might change the script to the following  
`screen -XS Daemon quit && sleep 60s && screen -dmS Daemon /home/username/X-CASH_CLI_Linux_1.5.0/xcashd --data-dir /home/username/X-CASH_blockchain`

Then make sure you are running the Daemon using the screen command. It is recommended to start the xcashd using  
`screen -dmS Daemon ./xcashd`

At this point, you will need to make a cron job to run this script. We recommend setting the cron job to every hour

`crontab -e`  
Choose your default editor  
Scroll to the bottom of the file and add this line  
`0 * * * * /PATH/TO/restart_daemon.sh`  
Save the file  
Restart the cron job service  
`sudo service cron reload`
