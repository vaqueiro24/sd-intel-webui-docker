FROM ubuntu:jammy

# Install Intel OneAPI Repositories
RUN \
  apt update \
  && apt-get install -y gpg-agent wget git \
  && sh -c "wget -qO - https://repositories.intel.com/graphics/intel-graphics.key | gpg --dearmor --output /usr/share/keyrings/intel-graphics.gpg" \
  && sh -c "echo 'deb [arch=amd64,i386 signed-by=/usr/share/keyrings/intel-graphics.gpg] https://repositories.intel.com/graphics/ubuntu jammy arc' |   tee  /etc/apt/sources.list.d/intel.gpu.jammy.list" \
  && sh -c "wget -O- https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB  | gpg --dearmor | tee /usr/share/keyrings/oneapi-archive-keyring.gpg > /dev/null" \
  && sh -c 'echo "deb [signed-by=/usr/share/keyrings/oneapi-archive-keyring.gpg] https://apt.repos.intel.com/oneapi all main" | tee /etc/apt/sources.list.d/oneAPI.list' \
  && apt update

# Install Dependencies
RUN \
  apt-get install -y \
    intel-level-zero-gpu \
    intel-media-va-driver-non-free \
    intel-oneapi-compiler-dpcpp-cpp \
    intel-oneapi-mkl \
    intel-opencl-icd \
    level-zero \
    libgl-dev \
    libglib2.0-0 \
    libmfx1 \
    python3-pip

# Create User Permissions
ARG DOCKER_USER=default_user
RUN useradd -m "$DOCKER_USER"

# Clone Repo
RUN \
  git clone --branch oneapi https://github.com/jbaboval/stable-diffusion-webui.git 
WORKDIR stable-diffusion-webui
# Change torch/pytorch version to be downloaded (uncomment to download IDP version instead)
RUN sed -i 's#pip install torch==1.13.1+cu117 torchvision==0.14.1+cu117 --extra-index-url https://download.pytorch.org/whl/cu117#pip install pillow mkl torch==1.13.0a0 torchvision==0.14.1a0 intel_extension_for_pytorch==1.13.10+xpu -f https://developer.intel.com/ipex-whl-stable-xpu#g' launch.py
#RUN sed -i 's#ipex-whl-stable-xpu#ipex-whl-stable-xpu-idp#g' launch.py

# Run Once to Cache Torch Dependencies
SHELL ["/bin/bash", "-c"] 
RUN \
  source /opt/intel/oneapi/setvars.sh \
  && python3 launch.py --nowebui --skip-torch-cuda-test --exit

# Allow Config to Persist
RUN mkdir config \
  && touch config/config.json \
  && ln -s config/config.json config.json

# Start Container
RUN chown -R $DOCKER_USER:$DOCKER_USER /stable-diffusion-webui
USER $DOCKER_USER
COPY start.sh /usr/local/bin
CMD ["start.sh"]
