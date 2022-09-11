FROM paperspace/gradient-base:pt112-tf29-jax0314-py39-updated

# Install Python packages for stable-diffusion
RUN pip install --upgrade pip && pip install -U numpy --prefer-binary \
    && pip install wheel transformers==4.19.2 diffusers invisible-watermark --prefer-binary \
    && pip install git+https://github.com/crowsonkb/k-diffusion.git --prefer-binary --only-binary=psutil \
    && pip install git+https://github.com/TencentARC/GFPGAN.git --prefer-binary

# Clone and get requirements for webui
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git stable-diffusion \
    && pip install -r stable-diffusion/requirements_versions.txt --prefer-binary

WORKDIR /stable-diffusion

# Clone base repositories
RUN git clone https://github.com/CompVis/stable-diffusion.git repositories/stable-diffusion \
    && git clone https://github.com/CompVis/taming-transformers.git repositories/taming-transformers \
    && git clone https://github.com/sczhou/CodeFormer.git repositories/CodeFormer \
    && pip install -r repositories/CodeFormer/requirements.txt --prefer-binary

# Copy basic config
COPY config.json .