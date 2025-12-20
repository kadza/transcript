import torch
from pyannote.audio import Pipeline
from pydub import AudioSegment

# ----------------------------
# Load pipeline
# ----------------------------
pipeline = Pipeline.from_pretrained(
    "pyannote/speaker-diarization-community-1", use_auth_token="YOUR_HF_TOKEN"
)

# GPU for the pipeline
device_gpu = torch.device("cuda:0" if torch.cuda.is_available() else "cpu")
pipeline.to(device_gpu)
print(f"Pipeline loaded on: {device_gpu}")

# ----------------------------
# Split audio into safe chunks
# ----------------------------
audio_file = "long_audio.wav"
audio = AudioSegment.from_file(audio_file)
chunk_length_sec = 10  # shorter chunks for embeddings
chunks = [
    audio[i : i + chunk_length_sec * 1000]
    for i in range(0, len(audio), chunk_length_sec * 1000)
]
print(f"Total chunks: {len(chunks)}")

# ----------------------------
# Process chunks
# ----------------------------
all_outputs = []

for i, chunk in enumerate(chunks):
    chunk_path = f"chunk_{i}.wav"
    chunk.export(chunk_path, format="wav")

    # Temporarily move embedding model to CPU
    pipeline.speaker_embedding_model.to(torch.device("cpu"))

    # Run diarization on this chunk
    output = pipeline(chunk_path)
    all_outputs.append(output)

    # Move embedding model back to GPU (optional)
    pipeline.speaker_embedding_model.to(device_gpu)

    if device_gpu.type == "cuda":
        print(
            f"Chunk {i}: "
            f"Allocated {torch.cuda.memory_allocated() / 1024**2:.1f} MB, "
            f"Reserved {torch.cuda.memory_reserved() / 1024**2:.1f} MB"
        )
        torch.cuda.empty_cache()

# ----------------------------
# Combine outputs
# ----------------------------
# You can merge `all_outputs` into a single timeline if needed
