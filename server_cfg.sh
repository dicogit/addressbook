sudo yum install java-1.8.0-openjdk-devel -y
sudo yum install git -y
sudo yum install maven -y
if [ -d "addressbook" ];
then
  echo "repo is cloned and exists"
  cd /home/ec2-user/addressbook
  git pull origin pipe
else
  git clone https://github.com/dicogit/addressbook.git
  cd /home/ec2-user/addressbook
  git checkout pipe
fi
mvn packag