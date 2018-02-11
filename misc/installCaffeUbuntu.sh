# Draft script, You cannot run at this point
exit
apt-get -y install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler
apt-get -y install --no-install-recommends libboost-all-dev

cd
mkdir -p Downloads
cd Downloads
wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/local_installers/cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64-deb
dpkg -i cuda-repo-ubuntu1604-8-0-local-ga2_8.0.61-1_amd64-deb
apt-get update
apt-get -y install cuda

wget https://developer.nvidia.com/compute/cuda/8.0/Prod2/patches/2/cuda-repo-ubuntu1604-8-0-local-cublas-performance-update_8.0.61-1_amd64-deb
dpkg -i cuda-repo-ubuntu1604-8-0-local-cublas-performance-update_8.0.61-1_amd64-deb

apt-get -y install libatlas-base-dev libgflags-dev libgoogle-glog-dev liblmdb-dev

apt-get -y install python-dev

# now install caffe either from source or pre-compiled repo
cd
mkdir -p Workspace
cd Workspace
git clone https://github.com/BVLC/caffe.git
cd caffe
make all -j8
make test
make runtest

# Install python 36 data rider's world: anaconda
wget https://repo.continuum.io/archive/Anaconda3-5.0.1-Linux-x86_64.sh
# have to install it manually https://www.digitalocean.com/community/tutorials/how-to-install-the-anaconda-python-distribution-on-ubuntu-16-04
....
# Install boost that comaptible with 36
conda install -c anaconda boost
# Now caffe need to use 36 python 

