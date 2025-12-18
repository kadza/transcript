import torch
from pyannote.audio import Pipeline, Inference
from pyannote.audio.core.task import Specifications
from pyannote.core import Segment, Annotation

# -----------------------------
# Step 1: Fix nightly PyTorch unpickling issue
# -----------------------------
torch.serialization.add_safe_globals([Specifications])

# -----------------------------
# Step 2: Set paths
# -----------------------------
model_dir = "/home/luke/.cache/huggingface/hub/models--pyannote--speaker-diarization-community-1/snapshots/3533c8cf8e369892e6b79ff1bf80f7b0286a54ee"  # contains config.yaml + segmentation/
audio_file = "/home/luke/dev/whisper.cpp/samples/rkharate.wav"

# -----------------------------
# Step 3: Create segmentation inference
# -----------------------------
segmentation_inference = Inference(model_dir, device="cuda")  # or "cpu"

# -----------------------------
# Step 4: Run segmentation
# -----------------------------
# This produces speech/non-speech probabilities (SlidingWindowFeature)
segmentation_scores = segmentation_inference(audio_file)

# -----------------------------
# Step 5: Convert segmentation to speech regions
# -----------------------------
# Threshold can be adjusted (0.5 is typical)
speech_regions = segmentation_scores.crop(segmentation_scores > 0.5)

# -----------------------------
# Step 6: Speaker diarization (simplest approach)
# -----------------------------
# This example uses pyannote.audio's built-in speaker clustering
from pyannote.audio.pipelines import SpeakerDiarization

# Create a speaker diarization pipeline using your segmentation model
pipeline = SpeakerDiarization(segmentation=segmentation_inference, device="cuda")

# Run diarization
diarization = pipeline({"uri": "test_audio", "audio": audio_file})

# -----------------------------
# Step 7: Inspect results
# -----------------------------
for segment, track, speaker in diarization.itertracks(yield_label=True):
        print(f"Speaker {speaker}: {segment.start:.2f}s → {segment.end:.2f}s")

        # -----------------------------
        # Optional: Save results to file
        # -----------------------------
        diarization_file = "diarization.rttm"
        with open(diarization_file, "w") as f:
                diarization.write_rttm(f)

                print(f"Diarization saved to {diarization_file}")

