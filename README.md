# sd-intel-webui-docker
Easy Docker setup for Stable Diffusion with user-friendly UI and Intel GPUs

And yes, this container isn't pretty looking but it got me from point A to point B. If you look at the code and notice that I did something redundant, or outright wrong, then thats probably the case. Feel free to contribute and make this thing better in any way!

## Setup
- Clone the repository and `cd` into the new folder
- run `docker compose up download` to setup the folders
- run `docker compose up webui` to build and bring up the container
- open the webui with `<ip of PC/server>:7860`

## Credits

- Major props to u/theshdude on Reddit for writing detailed instructions on how to set up ubuntu for Intel oneAPI and stable diffusion
  - https://www.reddit.com/r/IntelArc/comments/11an12q/stable_diffusion_web_ui_for_intel_arc/
- jbaboval on github for his fork of stable-diffusion-webui for Intel oneAPI
  - https://github.com/jbaboval/stable-diffusion-webui/tree/oneapi
- AbdBarho for the original stable-diffusion-webui-docker, I took and modified his download container for my own purposes
  - https://github.com/AbdBarho/stable-diffusion-webui-docker
- AUTOMATIC1111 for all his work on stable-diffusion-webui in general!
  - https://github.com/AUTOMATIC1111/stable-diffusion-webui
