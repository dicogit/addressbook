sudo yum install java-1.8.0-amazon-corretto-devel.x86_64 -y 
sudo yum install git -y
sudo yum install maven -y
git clone https://github.com/dicogit/addressbook.git
if [-d 'addressbook']
then
    echo "clone exist"
    cd /home/ec2-user/addressbook
    git pull origin pipe
else
    git clone https://github.com/dicogit/addressbook.git
fi
cd /home/ec2-user/addressbook
mvn package

