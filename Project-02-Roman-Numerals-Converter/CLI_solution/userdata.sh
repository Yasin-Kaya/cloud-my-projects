#! /bin/bash
yum update -y
yum install python3 -y
pip3 install flask
yum install git -y
cd /home/ec2-user
wget -P templates https://raw.githubusercontent.com/Kaya-Y/cloud-my-projects/main/Project-02-Roman-Numerals-Converter/templates/index.html
wget -P templates https://raw.githubusercontent.com/Kaya-Y/cloud-my-projects/main/Project-02-Roman-Numerals-Converter/templates/result.html
wget https://raw.githubusercontent.com/Kaya-Y/cloud-my-projects/main/Project-02-Roman-Numerals-Converter/app.py
python3 app.py
