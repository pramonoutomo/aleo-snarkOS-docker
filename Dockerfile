FROM ubuntu:20.04 AS base
RUN echo "This script are based on Nodes.guru scripts and modded by pramonoutomo @codeblocklabs"
RUN curl -s https://api.nodes.guru/swap4.sh | bash
ENTRYPOINT ["./swap4.sh"]
RUN apt update && apt install wget jq screen make clang pkg-config libssl-dev build-essential gcc xz-utils git curl vim tmux ntp jq llvm ufw -y && apt clean
RUN rm -rf $HOME/snarkOS $(which snarkos) $(which snarkos) $HOME/.aleo $HOME/aleo
RUN cd $HOME
RUN git clone https://github.com/AleoHQ/snarkOS.git --depth 1
RUN cd snarkOS
RUN echo "=================================================="
RUN echo -e 'Installing snarkos ...\n' && sleep 1
RUN bash ./build_ubuntu.sh
ENTRYPOINT ["./build_ubuntu.sh"]
RUN source $HOME/.bashrc
RUN source $HOME/.cargo/env
RUN mkdir $HOME/aleo
RUN echo -e 'Success install aleo snarkOS...\n' && sleep 1