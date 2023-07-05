## CoreMLaMa: LaMa for Core ML

This repo contains a script for converting a [LaMa](https://advimman.github.io/lama-project/) (aka cute, fuzzy 🦙) model to Apple's Core ML model format.

### Conversion Instructions

1. Create a Conda environment for CoreMLaMa:
    ```sh
    conda create -n coremllama python=3.10 # works with mamba, too
    conda activate coremllama
    pip install -r requirements.txt
    ```

2. Run the conversion script:
    ```sh
    python convert_lama.py
    ```

This script will download and convert [Big LaMa](https://github.com/advimman/lama#models-options) to a Core ML package named `LaMa.mlpackage`.

### Acknowledgements and Thanks

Thanks to the authors of LaMa:

[[Project page](https://advimman.github.io/lama-project/)] [[arXiv](https://arxiv.org/abs/2109.07161)] [[Supplementary](https://ashukha.com/projects/lama_21/lama_supmat_2021.pdf)] [[BibTeX](https://senya-ashukha.github.io/projects/lama_21/paper.txt)] [[Casual GAN Papers Summary](https://www.casualganpapers.com/large-masks-fourier-convolutions-inpainting/LaMa-explained.html)]


CoreMLaMa uses the LaMa model and supporting code from [Lama Cleaner](https://github.com/Sanster/lama-cleaner). Lama Cleaner makes this project much simpler.
