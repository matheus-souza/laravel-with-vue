Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/bionic64"
    config.vm.network :forwarded_port, guest: 80, host: 80
    config.vm.network :private_network, ip: "192.168.101.101"
    config.vm.synced_folder ".", "/nameless", owner: "www-data", group: "www-data", mount_options: ['dmode=777','fmode=666']
    config.vm.synced_folder "~", "/vagrant", owner: "vagrant", group: "vagrant"
    config.vm.provider "virtualbox" do |machine|
      machine.memory = 1024
      machine.name = "laravel-with-vue"
    end
    config.trigger.before :ssh do |trigger|
      trigger.info = "Executando ./run..."
      trigger.run = {path: "ls"}
    end
    config.vm.provision :shell, path: "./infra/vagrant/setup.sh"
end
