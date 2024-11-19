## CoreMLaMa: LaMa for Core ML

This repo contains a script for converting a [LaMa](https://advimman.github.io/lama-project/) (aka cute, fuzzy 🦙) model to Apple's Core ML model format. More specifically, it converts the implementation of LaMa from [Lama Cleaner](https://github.com/Sanster/lama-cleaner).

This repo also includes a simple example of how to use the Core ML model for prediction. See [Sample](Sample).

### Conversion Instructions

1. Create a Conda environment for CoreMLaMa:
    ```sh
    conda create -n coremlama python=3.10 # works with mamba, too
    conda activate coremlama
    pip install -r requirements.txt
    ```

2. Run the conversion script:
    ```sh
    python convert_lama.py
    ```

This script will download and convert [Big LaMa](https://github.com/advimman/lama#models-options) to a Core ML package named LaMa.mlpackage.

### iOS Deployment Problems

The Core ML model this script produces was designed for macOS deployments. It runs well on macOS, on the GPU. I have received several reports of unsuccessful attempts to run this model on iOS, especially with fp16 precision on the Neural Engine. Conversely, I have not received any reports of _successful_ deployments to iOS.

It may very well be possible to run this model on iOS with some tuning in the conversion process. I simply have not attempted this. I would very much welcome a PR and give credit to anyone who is able to convert this model and run it with great results on iOS.

### Acknowledgements and Thanks

Thanks to the authors of LaMa:

[[Project page](https://advimman.github.io/lama-project/)] [[arXiv](https://arxiv.org/abs/2109.07161)] [[Supplementary](https://ashukha.com/projects/lama_21/lama_supmat_2021.pdf)] [[BibTeX](https://senya-ashukha.github.io/projects/lama_21/paper.txt)] [[Casual GAN Papers Summary](https://www.casualganpapers.com/large-masks-fourier-convolutions-inpainting/LaMa-explained.html)]

CoreMLaMa uses the LaMa model and supporting code from [Lama Cleaner](https://github.com/Sanster/lama-cleaner). Lama Cleaner makes this project much simpler.
