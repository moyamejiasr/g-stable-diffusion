FROM paperspace/gradient-base:pt112-tf29-jax0314-py39-updated

# Get conda for textual-inversion
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.12.0-Linux-x86_64.sh \
    && chmod +x Miniconda3-py39_4.12.0-Linux-x86_64.sh \
    && ./Miniconda3-py39_4.12.0-Linux-x86_64.sh -b -p $HOME/miniconda3

# Clone and install env for stable-inversion
RUN git clone https://github.com/lstein/stable-diffusion.git stable-inversion \
    && $HOME/miniconda3/bin/conda env create -f stable-inversion/environment.yaml

# Preload machine
RUN $HOME/miniconda3/bin/conda run --no-capture-output -n ldm python -u /stable-inversion/scripts/preload_models.py

# TODO. Fix.
# ln -s /datasets/waifu-diffusion /stable-inversion/models/ldm/stable-diffusion-v1

# cd stable-inversion
# $HOME/miniconda3/bin/conda run --no-capture-output -n ldm python -u ./main.py --base ./configs/stable-diffusion/v1-finetune.yaml -t --actual_resume ./models/ldm/stable-diffusion-v1/model.ckpt -n panamaman --gpus '0,' --data_root /notebooks/fraction --init_word 'anime'