# SARotate
For rotating Google service accounts to bypass bans or any other myriad of reasons.

"I am not a coder. I have no idea what I am doing. Use at your own risk!"

## What is it?
This script was created with the help (more like written) of 88lex. It uses portion of his amazing sasync (https://github.com/88lex/sasync) script. This was written mainly for CloudBox users but can be utilized by anyone.

## Installation
1. `cd /opt` 

2. `git clone github.com/Visorask/sarotate.git`

3. `sudo chown -R user:group sarotate` - Run `id` to find your user / group.

4. `cd /opt/sarotate && chmod +x sarotate`

5. `nano sarotate` Edit the variables to match your settings. Save and close.

5. If you would like to use crontab then follow the below steps:
  5a. `crontab -e`
  
  5b. Add `@reboot /opt/sarotate/sarotate`
  
  5c. Only thing is this might start before the mount so be aware.
  
6. `cd /opt/sarotate/system`

  6a. `nano sarotate.service`
  
  6b. Edit the user / group from `changethis` to your user / group. -Run `id` to find your user / group. 
  
  6c. Exit and save the file. 
  
  6d. `sudo cp /opt/sarotate/system/sarotate.service /etc/systemd/system/`
  
  6e. `sudo systemctl daemon-reload`
  
  6f. `sudo systemctl enable sarotate.service`
  
  6g. `sudo systemctl start sarotate.service`
  
  6h. If you would like to check that it is running working correctly run: `sudo service sarotate status`


