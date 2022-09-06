FROM paperspace/gradient-base:pt112-tf29-jax0314-py39-updated

# Install Miniconda3
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.12.0-Linux-x86_64.sh \
    && chmod +x Miniconda3-py39_4.12.0-Linux-x86_64.sh \
    && ./Miniconda3-py39_4.12.0-Linux-x86_64.sh -b -p $HOME/miniconda3

# Get Stable Diffusion as a notebook
RUN wget https://github.com/hlky/stable-diffusion/archive/refs/heads/main.zip  \
    && unzip main.zip && mv stable-diffusion-main stable-diffusion && rm main.zip \
    && $HOME/miniconda3/bin/conda env create -f stable-diffusion/environment.yaml

# Get Latent Diffusion inside the notebook
RUN wget https://github.com/devilismyfriend/latent-diffusion/archive/refs/heads/main.zip  \
    && unzip main.zip && mv latent-diffusion-main stable-diffusion/src/latent-diffusion && rm main.zip

# Get pretrained model data into cache
RUN wget https://github.com/DagnyT/hardnet/raw/master/pretrained/train_liberty_with_aug/checkpoint_liberty_with_aug.pth \
    -P /root/.cache/torch/hub/checkpoints