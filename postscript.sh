#! /bin/bash

echo "Hello $(whoami), Welcome to the Post-Script";
echo "You are running this script on and at $(date)";

echo "Saving system info on MACHINE.txt";
home_dir=/home/$USER;
uname -a > "$home_dir/MACHINE.txt";

echo "Changing permissions to READ ONLY [444] for MACHINE.txt";
sudo chmod 444 "$home_dir/MACHINE.txt";

echo "Installing httpd";
sudo yum install httpd;
httpd_path=/var/www/html;
sudo wget https://netflix.com -O $httpd_path/netflix.html;
sudo systemctl start httpd;
sudo systemctl enable httpd;
echo "Paste on a new tab of your web browser : http://$(curl ipinfo.io/ip):80/netflix.html";
echo "Ensure your firewall allows inbound traffic to port 80";

echo "Jenkins Task";
jenkins_dir=/var/jenkins_home/secrets/initialAdminPassword;
echo "Here is the Jenkins secret, paste it on the Dashboard running on PORT:8080 : $(cat) $jenkins_dir";
