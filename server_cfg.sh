sudo yum install java -y
sudo yum install git -y
sudo yum install maven -y
sudo git clone https://github.com/dicogit/addressbook.git
if [ -d "addressbook" ];
then
    echo "clone exist"
    cd /home/ec2-user/addressbook
    git pull origin pipe
else
    git clone https://github.com/dicogit/addressbook.git
    cd /home/ec2-user/addressbook
    git checkout pipe
fi
sudo cd /home/ec2-user/addressbook
#git checkout pipe
sudo mvn package

