FROM paperspace/gradient-base:pt112-tf29-jax0314-py39-updated

# Install Python packages for stable-diffusion
RUN pip install --upgrade pip && pip install -U numpy --prefer-binary \
    && pip install wheel transformers==4.19.2 diffusers invisible-watermark --prefer-binary \
    && pip install git+https://github.com/crowsonkb/k-diffusion.git@1a0703dfb7d24d8806267c3e7ccc4caf67fd1331 --prefer-binary --only-binary=psutil \
    && pip install git+https://github.com/TencentARC/GFPGAN.git@8d2447a2d918f8eba5a4a01463fd48e45126a379 --prefer-binary

# Clone and get requirements for webui
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git stable-diffusion \
    && pip install -r stable-diffusion/requirements_versions.txt --prefer-binary

WORKDIR /stable-diffusion

# Clone base repositories
RUN git clone https://github.com/CompVis/stable-diffusion.git repositories/stable-diffusion \
    && git clone https://github.com/CompVis/taming-transformers.git repositories/taming-transformers \
    && git clone https://github.com/sczhou/CodeFormer.git repositories/CodeFormer \
    && pip install -r repositories/CodeFormer/requirements.txt --prefer-binary \
    && git clone https://github.com/salesforce/BLIP.git repositories/BLIP \
    && git -C repositories/BLIP checkout 48211a1594f1321b00f14c9f7a5b4813144b2fb9

# Copy basic config
COPY config.json .

# Run pre-caching proccess
ADD precache.py ./repositories/stable-diffusion/scripts
RUN chmod +x ./repositories/stable-diffusion/scripts/precache.py \
    && python ./repositories/stable-diffusion/scripts/precache.py