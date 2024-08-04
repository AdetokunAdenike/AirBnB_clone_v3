#!/usr/bin/env bash
# sets up the web servers for the deployment of web_static

sudo apt-get -y update
sudo apt-get -y upgrade
sudo apt-get -y install nginx
sudo apt-get -y install libmysqlclient-dev
pip3 install mysqlclient
pip3 install sqlalchemy
sudo mkdir -p /data/web_static/releases/test /data/web_static/shared
echo "This is a test" | sudo tee /data/web_static/releases/test/index.html
sudo ln -sf /data/web_static/releases/test/ /data/web_static/current
sudo chown -hR ubuntu:ubuntu /data/
sudo sed -i '38i\\tlocation /hbnb_static/ {\n\t\talias /data/web_static/current/;\n\t}\n' /etc/nginx/sites-available/default
sudo service nginx restart

export HBNB_ENV=test
export HBNB_MYSQL_USER=hbnb_test
export HBNB_MYSQL_PWD=hbnb_test_pwd
export HBNB_MYSQL_HOST=localhost
export HBNB_MYSQL_DB=hbnb_test_db
export HBNB_TYPE_STORAGE=db

python3 -m unittest discover tests