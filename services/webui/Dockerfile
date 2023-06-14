FROM intel/intel-extension-for-pytorch:gpu

RUN \
  apt-get update \
  && apt-get upgrade -y \
  && apt-get install git python3-pip libgl1-mesa-glx -y

# Create User Permissions
ARG DOCKER_USER=default_user
RUN useradd -m "$DOCKER_USER"

# Clone Repo
RUN \
  git clone --branch oneapi https://github.com/jbaboval/stable-diffusion-webui.git 
WORKDIR stable-diffusion-webui
# Change torch/pytorch version to be downloaded (uncomment to download IDP version instead)
RUN sed -i 's#pip install torch==2.0.0 torchvision==0.15.1 --extra-index-url https://download.pytorch.org/whl/cu118#pip install --ignore-installed pillow mkl torch==1.13.0a0+git6c9b55e torchvision==0.14.1a0 intel_extension_for_pytorch==1.13.120+xpu -f https://developer.intel.com/ipex-whl-stable-xpu#g' launch.py
#RUN sed -i 's#ipex-whl-stable-xpu#ipex-whl-stable-xpu-idp#g' launch.py

# Run Once to Cache Torch Dependencies
SHELL ["/bin/bash", "-c"] 
RUN python3 launch.py --nowebui --skip-torch-cuda-test --exit

# Allow Config to Persist
RUN mkdir config \
  && touch config/config.json \
  && ln -s config/config.json config.json

# Start Container
RUN chown -R $DOCKER_USER:$DOCKER_USER /stable-diffusion-webui
USER $DOCKER_USER
COPY start.sh /usr/local/bin
CMD ["start.sh"]