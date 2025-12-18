import torchaudio

print("torchaudio version:", torchaudio.__version__)
print("Available backends:", torchaudio.list_audio_backends())