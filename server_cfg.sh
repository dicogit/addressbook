sudo yum install java-1.8.0-openjdk-devel -y
sudo yum install git -y
sudo yum install maven -y
sudo yum install docker -y
sudo systemctl start docker
if [ -d "addressbook" ];
then
    echo "repo is cloned and exists"
    cd /home/ec2-user/addressbook
    git pull origin pipe
    git checkout pipe
else
    git clone https://github.com/dicogit/addressbook.git
    cd /home/ec2-user/addressbook
    git checkout pipe
fi
mvn package
sudo cp /home/ec2-user/addressbook/target/addressbook.war /home/ec2-user/addressbook/
sudo docker build -t $1:$2 /home/ec2-user/addressbook/
