FROM paperspace/gradient-base:pt112-tf29-jax0314-py39-updated

# Install Python packages for stable-diffusion
RUN pip install --upgrade pip && pip install -U numpy --prefer-binary

# Clone and get requirements for webui
RUN git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git stable-diffusion

WORKDIR /stable-diffusion

# Copy basic config
COPY config.json .

ENV COMMANDLINE_ARGS "--skip-torch-cuda-test --exit"
RUN python launch.py

# Run pre-caching proccess
ADD precache.py ./repositories/stable-diffusion/scripts
RUN chmod +x ./repositories/stable-diffusion/scripts/precache.py \
    && python ./repositories/stable-diffusion/scripts/precache.py