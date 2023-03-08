#!/bin/bash
source /opt/intel/oneapi/setvars.sh
cd /stable-diffusion-webui
# Change torch/pytorch version to be downloaded
sed -i 's#pip install torch==1.13.1+cu117 torchvision==0.14.1+cu117 --extra-index-url https://download.pytorch.org/whl/cu117#pip install pillow mkl torch==1.13.0a0 torchvision==0.14.1a0 intel_extension_for_pytorch==1.13.10+xpu -f https://developer.intel.com/ipex-whl-stable-xpu#g' launch.py
# Using my pre-patched, modified script instead to avoid GPU checks while installing all dependencies
python3 /setup.py --use-intel-oneapi --exit
