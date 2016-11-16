
Vagrant.configure(2) do |config|
  config.ssh.insert_key = false
  config.vm.box = "puppetlabs/centos-7.0-64-puppet"
  config.vm.hostname = "stadium"
  config.vm.provider "virtualbox" do |v|
    v.cpus = 2
    v.memory = 2048
  end
  config.vm.network "forwarded_port", guest: 8500, host: 8500
  config.vm.network "forwarded_port", guest: 5672, host: 5672
  config.vm.network "forwarded_port", guest: 15672, host: 15672
  config.vm.network "forwarded_port", guest: 8901, host: 8901
   config.vm.provision "shell", inline: <<-SHELL
	cd /vagrant/puppet
	sudo /opt/puppetlabs/bin/puppet module install stahnma-epel --version 1.2.2
	sudo /opt/puppetlabs/bin/puppet module install garethr-docker --version 5.3.0
	sudo /opt/puppetlabs/bin/puppet apply main.pp
	cd /vagrant
   SHELL
end
