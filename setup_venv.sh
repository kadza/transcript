#!/bin/bash

# Setup virtual environment for Jetson Orin Nano Whisper + pyannote development

echo "Creating virtual environment..."
python3 -m venv venv

echo "Activating virtual environment..."
source venv/bin/activate

echo "Upgrading pip, setuptools, and wheel..."
pip install --upgrade pip setuptools wheel

echo "Installing PyTorch ecosystem from Jetson AI Lab index..."
pip install --extra-index-url https://pypi.jetson-ai-lab.io/jp6/cu129/ \
    torch==2.9.0 \
    torchaudio==2.9.0 \
    torchcodec==0.8.0

echo "Installing Whisper and pyannote.audio..."
pip install openai-whisper pyannote.audio

echo "Virtual environment setup complete."
echo "To activate: source venv/bin/activate"
echo "Note: Ensure FFmpeg is built and installed as per README.md before running torchcodec-dependent code."