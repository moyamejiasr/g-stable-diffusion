#!/usr/bin/env python3
# Copyright (c) 2022 Lincoln D. Stein (https://github.com/lstein)
# Before running stable-diffusion on an internet-isolated machine,
# run this script from one with internet connectivity. The
# two machines must share a common .cache directory.
from transformers import CLIPTokenizer, CLIPTextModel
from transformers import BertTokenizerFast
import transformers

transformers.logging.set_verbosity_error()

# this will preload the Bert tokenizer files
print('Preloading bert tokenizer...')
tokenizer = BertTokenizerFast.from_pretrained('bert-base-uncased')
print('Success')

# this will preload clip
print('Preloading clip patch14...')
version = 'openai/clip-vit-large-patch14'
tokenizer = CLIPTokenizer.from_pretrained(version)
transformer = CLIPTextModel.from_pretrained(version)
print('\n\nSuccess')