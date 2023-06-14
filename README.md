# intel-stable-diffusion-webui-docker

jbaboval's Stable Diffusion WebUI for OneAPI - running in a Docker Container!

If you have an Intel Xe Graphics Card (e.g. Intel Arc), then this container
will allow you to use it for Stable Diffusion.

This container uses the Torch backend with some special Intel Repos to make
everything work. ~~Support for OneAPI in Torch is still early-days and there are
certainly some bugs and missing features (img2img crashes, no seed
reproducibility) so keep that in mind.~~

### UPDATE 6/13/2023:

It seems like this is not the case anymore:
- upscaling seems to be mostly fixed and actually usable. 
- Seeds are *almost* reproducible, as in objects and people are in place but there may be slight color variations.
- img2img was already working before and still works with this update

If you have an Intel Card and are interested in using it to diffuse, follow the
set-up steps below:

## Setup
- Clone this repository and cd:

```
 git clone https://github.com/vaqueiro24/sd-intel-webui-docker.git
 cd stable-diffusion-docker-webui-intel
 docker-compose up download -d      # Required once to set up some models and directories
 docker-compose up webui            # Build the container and run the WebUI
```
- Reach the webUI by navigating your browser to `localhost:7860`

## ENV Variables
| Parameter | Function |
| :----: | --- |
| `-e 443` | Internal WebUI Port - If you want to change the native port  |

## Special Thanks

- u/theshdude on Reddit for working with Intel Insiders to document setting up Torch for OneAPI
  - https://www.reddit.com/r/IntelArc/comments/11an12q/stable_diffusion_web_ui_for_intel_arc/
- jbaboval on github for his fork of stable-diffusion-webui for Intel oneAPI
  - https://github.com/jbaboval/stable-diffusion-webui/tree/oneapi
- AbdBarho for stable-diffusion-webui-docker that this work is based on
  - https://github.com/AbdBarho/stable-diffusion-webui-docker
- AUTOMATIC1111 for their Stable Diffusion WebUI
  - https://github.com/AUTOMATIC1111/stable-diffusion-webui
