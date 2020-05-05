# SARotate
For rotating Google service accounts to bypass bans or any other myriad of reasons.

"I am not a coder. I have no idea what I am doing. Use at your own risk!"

## What is it?
This script was created with the help of 88lex. It uses portion of his amazing sasync (https://github.com/88lex/sasync) script. This was written mainly for CloudBox users but can be utilized by anyone.

## Installation
1. `cd /opt` 

2. `git clone github.com/Visorask/sarotate.git`

3. `sudo chown -R user:group sarotate` - Run `id` to find your user / group.

4. `cd /opt/sarotate && chmod +x sarotate`

5. `nano sarotate` Edit the variables to match your settings. Save and close.

6. `nano set.sarotate` Add in w/e values you need.

   For the script to work you must edit your mounts to have either `--rc-no-auth` or `--rc-user=<username>` and `--rc-pass=<password>`. You can add those into a live mount by doing:
  
   - `sudo nano /etc/systemd/system/<nameofmount>.service` (Fill in <nameofmount> with your information.)
   - `sudo systemctl daemon-reload`
   - `sudo systemctl restart /etc/systemd/system/<nameofmount>.service` (Fill in <nameofmount> with your information.)
   - `./sarotate set.sarotate`

---
6. If you would like to use crontab then follow the below steps:
  - `crontab -e`
  
  - Add `@reboot /opt/sarotate/sarotate`
  
  - Only thing is this might start before the mount so be aware.
 ---
7. Use this one for `systemd`. 
  - `cd /opt/sarotate/system`
  
  - `nano sarotate.service`
  
  - Edit the user / group from `changethis` to your user / group. -Run `id` to find your user / group. 
  
  - Exit and save the file. 
  
  - `sudo cp /opt/sarotate/system/sarotate.service /etc/systemd/system/`
  
  - `sudo systemctl daemon-reload`
  
  - `sudo systemctl enable sarotate.service`
  
  - `sudo systemctl start sarotate.service`
  
  - If you would like to check that it is running working correctly run: `sudo service sarotate status`
---

