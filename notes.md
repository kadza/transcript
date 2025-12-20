TorchCodec as a “Client”

TorchCodec does not decode video itself.

It acts as a client/consumer that requests frames to be prepared by the upstream pipeline.

“Prepared” here means:

FFmpeg has demuxed and parsed the container → compressed video frames exist.

GStreamer + V4L2/NVDEC has decoded the frames → raw surfaces exist in NVMM.

CUDA interop has mapped or copied the surfaces → accessible as GPU memory.
