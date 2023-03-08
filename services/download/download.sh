#!/usr/bin/env bash

set -Eeuo pipefail

#if [ "$(ls -A stable-diffusion-webui)" ]; then
#    echo "folder stable-diffusion-webui is not empty, assuming already downloaded"
#else
#    echo "stable-diffusion-webui is empty, cloning from git"
#    git clone https://github.com/jbaboval/stable-diffusion-webui.git
#    cd stable-diffusion-webui
#    git checkout oneapi
#  sed -i 's#pip install torch==1.13.1+cu117 torchvision==0.14.1+cu117 --extra-index-url https://download.pytorch.org/whl/cu117#pip install pillow mkl torch==1.13.0a0 torchvision==0.14.1a0 intel_extension_for_pytorch==1.13.10+xpu -f https://developer.intel.com/ipex-whl-stable-xpu#g' launch.py
#fi

git clone https://github.com/jbaboval/stable-diffusion-webui.git SD
cd SD
git checkout oneapi
cd /

# TODO: maybe just use the .gitignore file to create all of these
mkdir -vp /stable-diffusion-webui/models/.cache /stable-diffusion-webui/models/Stable-diffusion /stable-diffusion-webui/models/Codeformer /stable-diffusion-webui/models/GFPGAN /stable-diffusion-webui/models/ESRGAN /stable-diffusion-webui/models/BSRGAN /stable-diffusion-webui/models/RealESRGAN /stable-diffusion-webui/models/SwinIR /stable-diffusion-webui/models/LDSR /stable-diffusion-webui/models/ScuNET /stable-diffusion-webui/models/embeddings /stable-diffusion-webui/models/VAE /stable-diffusion-webui/models/Deepdanbooru /stable-diffusion-webui/models/MiDaS /stable-diffusion-webui/models/Lora
cp -rv /SD/models/* /stable-diffusion-webui/models/

echo "Downloading, this might take a while..."

aria2c -x 10 --disable-ipv6 --input-file /docker/links.txt --dir /stable-diffusion-webui/models --continue

echo "Checking SHAs..."

parallel --will-cite -a /docker/checksums.sha256 "echo -n {} | sha256sum -c"

cat <<EOF
By using this software, you agree to the following licenses:
https://github.com/AbdBarho/stable-diffusion-webui-docker/blob/master/LICENSE
https://github.com/CompVis/stable-diffusion/blob/main/LICENSE
https://github.com/AUTOMATIC1111/stable-diffusion-webui/blob/master/LICENSE.txt
https://github.com/invoke-ai/InvokeAI/blob/main/LICENSE
https://github.com/sd-webui/stable-diffusion-webui/blob/master/LICENSE
https://github.com/cszn/BSRGAN/blob/main/LICENSE
https://github.com/sczhou/CodeFormer/blob/master/LICENSE
https://github.com/TencentARC/GFPGAN/blob/master/LICENSE
https://github.com/xinntao/Real-ESRGAN/blob/master/LICENSE
https://github.com/xinntao/ESRGAN/blob/master/LICENSE
https://github.com/cszn/SCUNet/blob/main/LICENSE
EOF
