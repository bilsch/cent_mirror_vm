#!/bin/sh

yum -y install man yum-utils createrepo httpd wget curl squid
chkconfig httpd on
service httpd start
yum -y install http://mirror.oss.ou.edu/epel/6/i386/epel-release-6-8.noarch.rpm

cp ~vagrant/updater_repo_files/*.repo /etc/yum.repos.d
echo "59 23 * * * bash /home/vagrant/scripts/reposync.sh" > /tmp/crontab
crontab -u vagrant /tmp/crontab
rm /tmp/crontab

cp ~vagrant/scripts/squid.conf /etc/squid
chkconfig squid on
service squid start
