#!/bin/bash
<<com
Supports colab, kaggle, jarvislabs, lambdalabs and paperspace environment setup
Usage:
bash setup.sh <ENVIRON> <download_data_or_not>
Example:
bash setup.sh jarvislabs true
com

ENVIRON=$1
DOWNLOAD_DATA=$2
PROJECT="DataSolve-WK-2022"

# get source code from GitHub
git config --global user.name "Gladiator07"
git config --global user.email "atharvaaingle@gmail.com"
git clone https://github.com/Gladiator07/DataSolve-WK-2022.git

if [ "$1" == "colab" ]
then
    cd /content/$PROJECT
    pip install datasets
    
elif [ "$1" == "kaggle" ]
then
    cd /kaggle/working/$PROJECT

elif [ "$1" == "jarvislabs" ]    
then    
    cd /home/$PROJECT
    pip install datasets
elif [ "$1" == "paperspace" ]
then
    cd /notebooks/$PROJECT
    pip install datasets
elif [ "$1" == "lambdalabs" ]
then
    cd /home/ubuntu/$PROJECT
    pip install tensorflow
    pip install datasets
    pip install protobuf==3.20.*
else
    echo "Unrecognized environment"
fi

# install deps
pip install numpy pandas omegaconf scikit_learn sentencepiece --upgrade
pip install transformers wandb kaggle rich iterative-stratification python-dotenv --upgrade
pip install git+https://github.com/huggingface/accelerate

source .env
export KAGGLE_USERNAME=$KAGGLE_USERNAME
export KAGGLE_KEY=$KAGGLE_KEY

if [ "$DOWNLOAD_DATA" == "true" ]
then
    mkdir input/
    cd input/

    # download competition data
    echo "Downloading data"
    kaggle datasets download -d atharvaingle/datasolve-dataset
    unzip datasolve-dataset.zip
    rm datasolve-dataset.zip
else
    echo "Data download disabled"
fi
