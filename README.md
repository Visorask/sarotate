# SARotate
For rotating Google service accounts to bypass bans or any other myriad of reasons.

## What is it?
This script was created with the help (more like written) of 88lex. It uses portion of his amazing sasync (https://github.com/88lex/sasync) script. This was written mainly for CloudBox users but can be utilized by anyone.

## Installation
1. `cd /opt` 

2. `sudo git clone git://github.com/Visorask/SARotate.git`

3. `sudo chown -R user:group SARotate - Run `id` to find your user / group.

4. `cd SARotate && chmod +x sarotate.sh`

5. `nano sarotate.sh` Edit the variables to match your settings. Save and close.

6. `cd /opt/SARotate/system`

7. `nano SARotate.service`

8. Edit the user / group from `changethis` to your user / group. -Run `id` to find your user / group. 

9. Exit and save the file. 

10. `sudo cp /opt/SARotate/system/SARotate.service /etc/systemd/system/`

11. `sudo systemctl daemon-reload`

12. `sudo systemctl enable SARotate.service`

13. `sudo systemctl start SARotate.service`
