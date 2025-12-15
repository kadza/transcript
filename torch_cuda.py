import torch
print(torch.version.cuda)  # CUDA version PyTorch was built with
print(torch.cuda.is_available())  # Should be True
print(torch.cuda.get_device_name(0))  # Your GPU name
print(torch.cuda.get_arch_list())

