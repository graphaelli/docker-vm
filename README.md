# docker-vm

To get started:

1. Install [vagrant](https://vagrantup.com/)
2. Install [vagrant-disksize](https://github.com/sprotheroe/vagrant-disksize) with: `vagrant plugin install vagrant-disksize`
3. Customize your [synced folder](https://github.com/graphaelli/docker-vm/blob/8ecacce10c07af1f70ae68e3964865c074e5eb85/Vagrantfile#L11)
4. Start the VM: `vagrant up`
5. Instruct [docker cli](https://github.com/docker/cli) to use a remote docker host with: `export DOCKER_HOST="127.0.0.1:2375"` (add this to your shell rc)
