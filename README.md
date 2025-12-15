
jetson orin nano architecture SM_87

*********
Could not find a version that satisfies the requirement torchcodec==0.7.0 (from pyannote-audio)

pip install -U torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu128

Exception occurred: CUDA error: no kernel image is available for execution on the device

not all torch releases binaries are built for sm_87 architecture 

https://github.com/meta-pytorch/torchcodec/issues/569

*********

File "/home/luke/dev/diarization/diarization.py", line 6, in <module> pipeline = Pipeline.from_pretrained( File "/home/luke/dev/diarization/venv/lib/python3.10/site-packages/pyannote/audio/core/pipeline.py", line 244, in from_pretrained pipeline = Klass(**params) File "/home/luke/dev/diarization/venv/lib/python3.10/site-packages/pyannote/audio/pipelines/speaker_diarization.py", line 222, in __init__ model: Model = get_model(segmentation, token=token, cache_dir=cache_dir) File "/home/luke/dev/diarization/venv/lib/python3.10/site-packages/pyannote/audio/pipelines/utils/getter.py", line 127, in get_model model = Model.from_pretrained(**model) File "/home/luke/dev/diarization/venv/lib/python3.10/site-packages/pyannote/audio/core/model.py", line 602, in from_pretrained loaded_checkpoint = pl_load(path_to_model_checkpoint, map_location=map_location) File "/home/luke/dev/diarization/venv/lib/python3.10/site-packages/lightning/fabric/utilities/cloud_io.py", line 73, in _load return torch.load( File "/home/luke/dev/diarization/venv/lib/python3.10/site-packages/torch/serialization.py", line 1548, in load raise pickle.UnpicklingError(_get_wo_message(str(e))) from None _pickle.UnpicklingError: Weights only load failed. This file can still be loaded, to do so you have two options, do those steps only if you trust the source of the checkpoint. (1) In PyTorch 2.6, we changed the default value of the weights_only argument in torch.load from False to True. Re-running torch.load with weights_only set to False will likely succeed, but it can result in arbitrary code execution. Do it only if you got the file from a trusted source. (2) Alternatively, to load with weights_only=True please check the recommended steps in the following error message. WeightsUnpickler error: Unsupported global: GLOBAL pyannote.audio.core.task.Specifications was not an allowed global by default. Please use torch.serialization.add_safe_globals([pyannote.audio.core.task.Specifications]) or the torch.serialization.safe_globals([pyannote.audio.core.task.Specifications]) context manager to allowlist this global if you trust this class/function.

it is resolved in pyannote.audio 4.0.3


https://docs.nvidia.com/deeplearning/frameworks/install-pytorch-jetson-platform/index.html

https://docs.nvidia.com/deeplearning/frameworks/install-pytorch-jetson-platform-release-notes/pytorch-jetson-rel.html#pytorch-jetson-rel

https://developer.nvidia.com/embedded/jetpack-archive
https://developer.nvidia.com/embedded/jetpack-sdk-621

https://docs.pytorch.org/audio/stable/build.jetson.html
