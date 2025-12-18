import whisper

model = whisper.load_model("small")
result = model.transcribe("sample.wav")
print(result["text"])