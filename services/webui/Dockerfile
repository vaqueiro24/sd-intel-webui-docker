FROM ubuntu:jammy
RUN apt update
RUN apt-get install -y gpg-agent wget git
RUN sh -c "wget -qO - https://repositories.intel.com/graphics/intel-graphics.key | gpg --dearmor --output /usr/share/keyrings/intel-graphics.gpg"
RUN sh -c "echo 'deb [arch=amd64,i386 signed-by=/usr/share/keyrings/intel-graphics.gpg] https://repositories.intel.com/graphics/ubuntu jammy arc' |   tee  /etc/apt/sources.list.d/intel.gpu.jammy.list"
RUN sh -c "wget -O- https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB  | gpg --dearmor | tee /usr/share/keyrings/oneapi-archive-keyring.gpg > /dev/null"
RUN sh -c 'echo "deb [signed-by=/usr/share/keyrings/oneapi-archive-keyring.gpg] https://apt.repos.intel.com/oneapi all main" | tee /etc/apt/sources.list.d/oneAPI.list'
RUN apt update && apt upgrade -y
RUN apt-get install -y intel-opencl-icd intel-level-zero-gpu level-zero intel-media-va-driver-non-free libmfx1 intel-oneapi-compiler-dpcpp-cpp intel-oneapi-mkl libgl-dev python3-pip
RUN apt-get install -y libglib2.0-0
COPY ./setup.py /
COPY ./setup.sh /
RUN git clone https://github.com/jbaboval/stable-diffusion-webui.git
WORKDIR stable-diffusion-webui
RUN git checkout oneapi
RUN bash /setup.sh
COPY ./start.sh /
RUN chmod +x /start.sh
ENV CLI_ARGS=""
EXPOSE 7860
CMD ["/start.sh"]
