#
# Simple vagrant image
#

Vagrant.configure("2") do |config|
  memory = 1024
  autostart = "on" # switch to on to ensure the vm stays up across host reboots
  config.vm.box = "chef/centos-6.5"
  config.vm.hostname = "updater"

  # apache on 80 and squid on 3128
  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 3128, host: 3128

  # These repo files go to /etc/yum.repos.d only on the updater VM
  config.vm.synced_folder "updater_repo_files", "/home/vagrant/updater_repo_files", create:true
  config.vm.synced_folder "scripts", "/home/vagrant/scripts", create:true
  config.vm.provision "shell", path: "scripts/install.sh"

  # The mirror data is stored on the local machine so we can upgrade safely later and not re-download everything
  config.vm.synced_folder "mirror_data", "/var/www/html/mirrors", create:true

  config.vm.provider :virtualbox do |vb|
    # Boot with headless mode
    vb.gui = false
    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id, "--memory", "#{memory}"]
    vb.customize ["modifyvm", :id, "--autostart-enabled", "#{autostart}"]
  end
end
