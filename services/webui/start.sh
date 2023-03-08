#!/bin/bash
source /opt/intel/oneapi/setvars.sh
cd /stable-diffusion-webui
python3 /stable-diffusion-webui/launch.py --use-intel-oneapi --listen --port 7860 ${CLI_ARGS}
