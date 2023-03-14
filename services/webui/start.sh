#!/bin/bash

# Execute
source /opt/intel/oneapi/setvars.sh
python3 launch.py --use-intel-oneapi --listen --port ${WEBUI_PORT:=7860} ${CLI_ARGS}
