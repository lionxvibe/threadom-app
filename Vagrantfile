# -*- mode: ruby -*-
Vagrant.configure("2") do |config|
  config.vm.define "master", primary: true do |master|
    master.vm.box = "tcfrocks/devnode"

    master.vm.network "forwarded_port", guest: 6379, host: 6379
    #master.vm.network "forwarded_port", guest: 5432, host: 5432

    master.vm.network :forwarded_port, guest: 22, host: 10122, id: "ssh"

    master.vm.network :private_network, ip: "192.168.56.101"

    master.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.memory = "2048"
    end

    master.vm.provision "docker" do |d|
      d.run "redis", image: "redis:latest", args: "-p 6379:6379"
      #d.run "postgres", image: "postgres:latest", args: "-p 5432:5432 -e POSTGRES_PASSWORD=password1 -e POSTGRES_USER=myapp -e POSTGRES_DB=myapp-test"
    end

    master.vm.provision :shell, inline: <<-EOT
      echo 'DOCKER_OPTS="-H unix:// -H tcp://0.0.0.0:2375 ${DOCKER_OPTS}"' >> /etc/default/docker
      service docker restart
    EOT
  end
  config.vm.define "wl", primary: true do |wl|
    wl.vm.box = "wl-boot2docker"
    wl.vm.box_url = "https://kazan.priv.atos.fr/share/data/vagrant-tech-user/boxes/stable/vbox/boot2docker/metadata.json"

    wl.vm.network "forwarded_port", guest: 6379, host: 6379
    wl.vm.network :forwarded_port, guest: 22, host: 10122, id: "ssh"

    wl.vm.network :private_network, ip: "192.168.56.101"

    wl.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
      vb.memory = "2048"
    end

    wl.vm.provision "docker" do |d|
      d.run "redis", image: "redis:latest", args: "-p 6379:6379"
    end

  end

end
