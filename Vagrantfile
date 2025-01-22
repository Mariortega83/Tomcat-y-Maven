# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.configure("2") do |config|
  config.vm.box = "debian/bullseye64"
  config.vm.define "tomcat" do |t|
    t.vm.hostname = "tomcat"
    t.vm.network "forwarded_port", guest: 8080, host: 8080
  end
  config.vm.provision "shell", path: "provision.sh"
end