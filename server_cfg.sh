sudo yum install java-1.8.0-openjdk-devel.x86_64 -y
sudo yum install git -y
sudo yum install maven -y
sudo git clone https://github.com/dicogit/addressbook.git
if [ -d "addressbook" ];
then
    echo "clone exist"
    echo "go to addressbook"
    cd /home/ec2-user/addressbook
    echo "pipe branch"
    git checkout pipe
else
    git clone https://github.com/dicogit/addressbook.git
    echo "go to addressbook"
    cd /home/ec2-user/addressbook
    echo "pipe branch"
    git checkout pipe
fi
#sudo cd /home/ec2-user/addressbook
#git checkout pipe
sudo mvn package

