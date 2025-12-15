from huggingface_hub import hf_hub_download, login

login(token="")

path = hf_hub_download(
    repo_id="pyannote/speaker-diarization-community-1", filename="pytorch_model.bin"
)
print(path)
