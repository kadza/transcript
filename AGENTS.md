# Agent Guidelines for Transcript Repository

## Commands
- **Run single test/check**: `python check_<component>.py` (e.g., `python check_cuda.py`)
- **Run all checks**: `python check_cuda.py && python check_ffmpeg.py && python check_torchaudio.py && python check_torchcodec.py`
- **No formal linting**: Use basic Python syntax checking
- **No build system**: Direct Python execution only

## Code Style
- **Imports**: One per line, standard library first, then third-party, grouped logically
- **Naming**: snake_case for variables/functions, PascalCase for classes
- **Formatting**: 4-space indentation, no trailing whitespace
- **Types**: No type hints required (optional for clarity)
- **Strings**: Use f-strings for formatting
- **Error handling**: Basic try/except where needed, print errors for debugging
- **Comments**: Minimal, only when code intent isn't obvious
- **Line length**: Keep under 100 characters when possible

## Project Conventions
- **Hardware target**: NVIDIA Jetson Orin Nano (ARM64, CUDA 12.9, sm_87)
- **Dependencies**: PyTorch ecosystem (torch, torchaudio, torchcodec), Whisper, pyannote.audio
- **File structure**: Simple scripts, no packages/modules
- **GPU usage**: Always check `torch.cuda.is_available()` before GPU operations
- **Audio files**: Use WAV format for samples, handle various codecs via FFmpeg