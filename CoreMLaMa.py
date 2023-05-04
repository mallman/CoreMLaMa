import torch

# A "wrapper" module around LaMa which handles some input/output
# pre- and post-processing beyond CoreML's built-in capabilities
class CoreMLaMa(torch.nn.Module):
    def __init__(self, lama):
        super(CoreMLaMa, self).__init__()
        self.lama = lama

    def forward(self, image, mask):
        normalized_mask = ((mask > 0) * 1).byte()
        lama_out = self.lama(image, normalized_mask)
        output = torch.clamp(lama_out * 255, min=0, max=255)
        return output
