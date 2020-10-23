#!/usr/bin/bash
# Boostrap installing
# Install only terminal app
yum -y groupinstall 'Development Tools'

# Install EPEL
yum -y install epel-release

# Install some tools essential for myself
yum -y install curl wget tree bzip2 zsh git
