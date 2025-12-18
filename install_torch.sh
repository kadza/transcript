#!/bin/bash

TORCH=https://pypi.jetson-ai-lab.io/jp6/cu129/+f/6c9/cd2a34c3ef563/torch-2.9.0-cp310-cp310-linux_aarch64.whl#sha256=6c9cd2a34c3ef563b9e715bf69075dcd65b4f74f430a751471695ed7306ab050
TORCH_AUDIO=https://pypi.jetson-ai-lab.io/jp6/cu129/+f/05e/01070bbc68ec7/torchaudio-2.9.0-cp310-cp310-linux_aarch64.whl#sha256=05e01070bbc68ec70c74c0b93ca54da0b2fa0a17ab65518f9a3f23de1a54366b
TORCH_CODEC=https://pypi.jetson-ai-lab.io/jp6/cu129/+f/8c8/d8f9d39366821/torchcodec-0.8.0-cp310-cp310-linux_aarch64.whl#sha256=8c8d8f9d393668210a2859810fff2c86279ba6b38992fe04e519eed2a43589e6
python3 -m pip install --upgrade pip
python3 -m pip install numpy=='1.26.1'
python3 -m pip install --no-cache $TORCH
python3 -m pip install --no-cache $TORCH_AUDIO
python3 -m pip install --no-cache $TORCH_CODEC
