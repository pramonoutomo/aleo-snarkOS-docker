---
version: "2.0"

services:
  app:
    image: ubuntu:20.04     
    
    command:
      - "bash"
      - "-c"
    args:
      - 'apt-get update ;
        apt-get upgrade -y ;
        apt-get install -y tzdata sudo wget systemd ;
        echo -e "0315011421\n0315011421" | passwd "root" ;
        sudo su - ;
        sudo apt-get install -y --reinstall iptables ;
        unlink /etc/localtime ;
        ln -s /usr/share/zoneinfo/America/New_York /etc/localtime ;
        apt-get install -y  make clang pkg-config libssl-dev build-essential gcc xz-utils git curl vim tmux ntp jq llvm ufw daemonize dbus-user-session fontconfig ;
        echo "==================================================" ;
        sudo curl -s https://api.nodes.guru/swap4.sh | bash ;
        echo "==================================================" ;
        echo -e "Installing dependencies...\n" && sleep 1 ;
        echo "=================================================="
        echo -e "Cloning snarkOS...\n" && sleep 1 ;
        rm -rf $HOME/snarkOS $(which snarkos) $(which snarkos) $HOME/.aleo $HOME/aleo ;
        cd $HOME ;
        git clone https://github.com/AleoHQ/snarkOS.git --depth 1 ;
        cd snarkOS ;
        echo "==================================================" ;
        echo -e "Installing snarkos ...\n" && sleep 1 ;
        sudo bash ./build_ubuntu.sh ;
        source $HOME/.bashrc ;
        source $HOME/.cargo/env ;
        echo -e "You aleo snarkOS machine ready to use...\n" && sleep 1 ;
        mkdir $HOME/aleo ;
        '
    
    expose:
      - port: 80
        as: 80
        to:
          - global: true
      - port: 22
        as: 22
        to:
          - global: true 
      - port: 4133
        as: 4133
        to:
          - global: true
      - port: 3033
        as: 3033
        to:
          - global: true
profiles:
  compute:
    app:
      resources:
        cpu:
          units: 32.0
        memory:
          size: 32Gi
        storage:
          size: 120Gi
         
  placement:
    akash: 
      attributes:
            
      pricing:
        app:
          denom: uakt
          amount: 10000
deployment:
  app:
    akash:
      profile: app
      count: 1 