# vim: set ft=ruby:
Vagrant.configure(2) do |config|
	ENV['VAGRANT_DEFAULT_PROVIDER'] = 'docker'
	ENV['VAGRANT_NO_PARALLEL'] = 'yes'
	config.vm.define "consul" do |config|
		config.vm.synced_folder ".", "/vagrant", disabled: true
		config.vm.provider "docker" do |d|
			d.image = "consul"
			d.has_ssh = false
			d.ports = [
				"8500:8500",
			]
		end
	end
	config.vm.define "registrator" do |config|
		config.vm.synced_folder ".", "/vagrant", disabled: true
		config.vm.provider "docker" do |d|
			d.image = "gliderlabs/registrator"
			d.has_ssh = false
			d.create_args = [
				"--net=host",
				"--volume=/var/run/docker.sock:/tmp/docker.sock"
			]
			d.cmd = [
				"-internal=true",
				"consul://localhost:8500",
			]
		end
	end
	config.vm.define "rabbitmq" do |config|
		config.vm.synced_folder ".", "/vagrant", disabled: true
		config.vm.provider "docker" do |d|
			d.image = "rabbitmq:3-management"
			d.has_ssh = false
			d.ports = [
				"5672:5672",
				"15672:15672",
				"61613:61613",
			]
		end
	end
	config.vm.define "postgres" do |config|
		config.vm.synced_folder ".", "/vagrant", disabled: true
		config.vm.provider "docker" do |d|
			d.image = "postgres"
			d.has_ssh = false
			d.ports = [
				"5432:5432",
			]
		end
	end
	config.vm.define "elasticsearch" do |config|
		config.vm.synced_folder ".", "/vagrant", disabled: true
		config.vm.provider "docker" do |d|
			d.image = "elasticsearch:5.1"
			d.has_ssh = false
			d.ports = [
				"9200:9200",
			]
		end
	end
	config.vm.define "stadium" do |config|
		config.vm.synced_folder ".", "/vagrant", disabled: true
		config.vm.provider "docker" do |d|
			d.build_dir = "."
			d.has_ssh = false
		end
	end
	vagrant_root = File.dirname(__FILE__);
	config.vm.define "test" do |config|
		config.vm.synced_folder ".", "/vagrant", disabled: true
		config.vm.provider "docker" do |d|
			d.build_dir = "./ssh-host"
			d.has_ssh = true
			d.volumes = [
				"#{vagrant_root}:/vagrant:z",
			]
		end
		config.vm.provision "shell", inline: <<-SCRIPT
			cd /vagrant
			bundle install
		SCRIPT
	
	end
end
