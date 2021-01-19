# SARotate
For rotating Google service accounts to bypass bans or any other myriad of reasons.

## Changelog 3.1
   - [Added] Pushover support for apprise. If your apprise notification is not a part of the script yet let me know.
   - [Changed] Added return code so the apprise doesn't go through every option, and only the 1 if off is returned.
   - [Changed] Changed text a little bit for log rotation.
   - [Fixed] Logr would return an issue with a character of the code. It is now fixed.

## Changelog 3.0
   - [Added] New version.
   - [Added] Uses a logger to easily identify issues.
   - [Added] Script will check to see if the config you loaded exists, has information and if it matches the name you input.
   - [Added] Much better logic for the handling of rotation.
   - [Added] Now has much more error handling built in to prevent simple mistakes.
   - [Added] Has a new `-h | help` option to let you know how to run the script. `./sarotate -h`
   - [Added] Can utilize the same service account on all teamdrives if you wish within the config.
   - [Added] Script will now check to see if your service accounts are within the minjs and maxjs set inside the config.
   - [Added] Script will now "remember" the last used service account. It does this by reading the last set service account and uses logic to determine if it needs to change it or use it.
   - [Added] Script will now rotate logs based on the size you have set. It will keep the last log file but with an appended number.
   - [Changed] Overall improved and made the script easier to read and fixed issues it had before.
   - [Changed] Changed apprise notifications. Now supports discord/slack by default with the config file.
   - [Old] Installs the dependency needed (yyq) to utilize the script.
   - [Old] Uses a .yml file for a more customized and easier configuration.
   - [Old] Uses passed arguments through -c if you want to use more than one config file.
   - [Old] Can define whichever rclone/lclone/fclone/gclone variant you want in config.
   - [Old] Can utilize different rclone config files in config.
   - [Old] Added header with version number and credits.
   - [Old] Comments in the .yml file will be stripped before being run through the script.
   - [Deleted] Old versions.

## What is it?
This script was created with the help of 88lex. This was written mainly for CloudBox users but can be utilized by anyone.

# Requirements
 1. Any dependencies needed are taken care of by the script besides rclone.
 2. rclone: `curl https://rclone.org/install.sh | sudo bash` | Minimum version of 1.51.

## Installation
1. `cd /opt`

2. `git clone https://github.com/Visorask/sarotate.git`

3. `sudo chown -R <user>:<group> sarotate` - Run `id` to find your user / group.

4. `cd /opt/sarotate && chmod +x sarotate`

5. `cp config.yml.sample config.yml` if you want comments in your config or `cp config.yml.nocomments config.yml` if you do not want comments.

# Config
```yml
# General rclone variables.
rclone:
  # Default rclone config. Change this if you have a non-standard rclone config location.
  rclone_config: "$HOME/.config/rclone/rclone.conf"
  # Match rclone rc mount user and pass. If you use --no-auth then leave as default.
  rc_user: "user"
  # Match rclone rc mount user and pass. If you use --no-auth then leave as default.
  rc_pass: "pass"
  # Default is localhost/127.0.0.1 but you can change this to match your IP for RC.
  ip: 127.0.0.1
# Global variables
global:
  # Minimum json file that you want to use.
  minjs: 3900
  # Maximum json file that you want to use.
  maxjs: 14000
  # Use 1 or 101.  101 will split API usage to separate projects, but needs many service accounts.
  nextjs: 101
  # Location of the directory with your service account files.
  json_dir: "/your/path/here"
  # Time the script will sleep for until running again.
  sleeptime: 15m
  # Set this if you would like to use the same service account for all remotes.
  # |on|off(default)|
  same_sa: off
# Log variables
log:
  # Name that you want your log file to have.
  logr_name: "sarotatetest"
  # Directory that you want your log files stored in.
  logr_dir: "/opt/sarotate/logs"
  # At what size do you want your log to rotate. 1 is default. (MB)
  logr_size: 1
  # How detailed do you want your output to be from the script.
  # |quiet(Supresses everything except errors and rclone output.)|verbose(default)(Everything is printed.)|
  logr_detail: verbose
  # rclone --log-level.
  # |DEBUG|INFO|ERROR(recommended)|NOTICE(default for rclone)|
  log_level: ERROR
apprise:
  # Apprise notifications.
  # |discord|slack|off(default)|
  notif: discord
  # Insert discord webhook information.
  # https://github.com/caronc/apprise/wiki/Notify_discord
  disc_id: "{WebhookID}/{WebhookToken}"
  # Insert webhook information.
  # https://github.com/caronc/apprise/wiki/Notify_slack
  slack_id: "{tokenA}/{tokenB}/{tokenC}"
  # Insert webhook information.
  # https://github.com/caronc/apprise/wiki/Notify_pushover
  pushover_id: "{user_key}@{token}"
# When filling these out you need to make sure the order of remote/port goes together or else
# the script will read wrong input/output and give errors.
main:
  remote:
   - teamdrive1
   - teamdrive2
   - teamdrive3
   - teamdrive4
  port:
   - 5572
   - 5573
   - 5574
   - 5575
```   

6. `nano config.yml` Edit the variables to match your settings. Save and close.

7. Once you have done all this then you will need to restart the mounts you want to rotate before running this script. A command might look like this: ```sudo systemctl restart <example>.service```

  Otherwise you might get an error like this:
```
Failed to rc: Failed to read rc response: 404 Not Found: {
        "error": "couldn't find method \"backend/command\"",
        "input": {
                "command": "set",
                "fs": "<remotename>:",
                "opt": {
                        "service_account_file": "<file/path/1.json>"
                }
        },
        "path": "backend/command",
        "status": 404
}
```

---

### Extra Information
   For the script to work you must edit your mounts to have either `--rc-no-auth` or `--rc-user=<username>` and `--rc-pass=<password>`. You can add those into a live mount by doing:

   - `sudo nano /etc/systemd/system/<nameofmount>.service` (Fill in <nameofmount> with your information.)
   - `sudo systemctl daemon-reload`
   - `sudo systemctl restart /etc/systemd/system/<nameofmount>.service` (Fill in <nameofmount> with your information.)
   - `./sarotate -c <config>.yml`


---

## If you would like to use crontab then follow the below steps:
  1. `crontab -e`
  2. Add `@reboot sleep 1m && /opt/sarotate/sarotate`
 ---

## If you would like to use systemd then follow the below steps:
  1. `cd /opt/sarotate/system`
  2. `nano sarotate.service`  
  3. Edit the user / group from `changethis` to your user / group. -Run `id` to find your user / group.   
  4. Exit and save the file.   
  5. `sudo cp /opt/sarotate/system/sarotate.service /etc/systemd/system/`  
  6. `sudo systemctl daemon-reload`  
  7. `sudo systemctl enable sarotate.service`  
  8. `sudo systemctl start sarotate.service`  
  9. If you would like to check that it is running working correctly run: `sudo service sarotate status`
---

## Troubleshooting
Will add more as people run into any issues.

# Donations

[PayPal](https://paypal.me/RRussell603)

BTC: 37iSj3YR1YP56fQi1Ue8fk1cYCuSmCugUB
