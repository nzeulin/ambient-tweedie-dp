#!/bin/bash
# A script to set up the pod environment
set -e

# 1. Update apt and install unzip (and wget for downloading files)
echo "Installing dependencies..."
apt-get update
apt-get install -y unzip wget

# 2. Download and install Miniconda3
echo "Installing Miniconda..."
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
bash miniconda.sh -b -p /root/.miniconda3
rm miniconda.sh

# 3. Create a new environment using installed Miniconda
echo "Creating Conda environment..."
source /root/.miniconda3/etc/profile.d/conda.sh
conda env create -f environment.yaml
conda activate ambient_tweedie
conda clean --all -y

# 4. Activate .env
echo "Setting up environment variables..."
source .env

# 5. Run script util_scripts/download_datasets.sh
echo "Downloading datasets..."
bash util_scripts/download_datasets.sh
cd /workspace/ambient-tweedie-dp

# 6. Running the script
accelerate launch train_text_to_image_lora_sdxl.py \
           --config=configs/train_high_level.yaml \
           --report_to=wandb \
           --expr_id=ffhq_high_test
