# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |configure|
  configure.vm.define "docker-vm" do |config|
    config.vm.boot_timeout = 600
    config.vm.box = "ubuntu/impish64"
    config.vm.network "public_network", bridge: "en0: Wi-Fi (Wireless)", use_dhcp_assigned_default_route: true
    config.vm.network "forwarded_port", guest: 2375, host: 2375, auto_correct: false, host_ip: "127.0.0.1"
    config.vm.network "forwarded_port", guest: 6443, host: 6443, auto_correct: false, host_ip: "127.0.0.1"
  
    config.vm.synced_folder "/Users/gil", "/Users/gil", disabled: false, :mount_options => ["ro"]
    config.disksize.size = '50GB'
  
    config.vm.provision "shell", inline: <<-SHELL
      sudo hostnamectl set-hostname docker-vm
      sudo sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list
      sudo apt autoremove -y
      sudo apt update
      sudo apt-get source linux-source
  
      sudo apt install -y virtualbox-guest-utils
  
      echo "Installing docker..."
      sudo apt install -y docker.io
      sudo usermod -aG docker ${USER}
      sudo mkdir -p /etc/systemd/system/docker.service.d
      sudo sh -c 'cat > /etc/systemd/system/docker.service.d/override.conf <<EOF
[Service]
# First clear to avoid: docker.service: Service has more than one ExecStart= setting, which is only allowed for Type=oneshot services. Refusing.
ExecStart=
ExecStart=/usr/bin/dockerd --containerd=/run/containerd/containerd.sock
EOF
'
    sudo sh -c 'cat > /etc/docker/daemon.json <<EOF
{"hosts": ["tcp://0.0.0.0:2375", "unix:///var/run/docker.sock"]}
EOF
'
      sudo systemctl daemon-reload
      sudo systemctl restart docker.service

      echo "Installing go..."
      curl -Ls https://dl.google.com/go/go1.17.8.linux-amd64.tar.gz | sudo tar -C /usr/local -xzf -

      echo "Installing microk8s..."
      sudo snap install microk8s --classic
      sudo usermod -a -G microk8s ${USER}
   
      echo "Installing utilities..."
      sudo apt install -y curl net-tools ntpdate unzip vim
      sudo timedatectl set-ntp true
      curl -sLo /tmp/pf-host-agent.deb https://releases.prodfiler.com/release-2.0.0/pf-host-agent_2.0.0_amd64.deb
      sudo dpkg -i /tmp/pf-host-agent.deb
  
      echo "Provisioning complete"
    SHELL
  
    config.vm.provider "virtualbox" do |v|
      v.customize ["modifyvm", :id, "--nictype1", "virtio"]
      v.memory = 12288
      v.cpus = 4
      v.name = "docker-vm"
    end
  end
end
