# frozen_string_literal: true

# Markdownlint style file
# File syntax: Ruby (Markdownlint Style DSL)
#

all
rule 'MD003', style: :atx
rule 'MD007', indent: 4
rule 'MD013', line_length: 120, code_blocks: false
rule 'MD029', style: :ordered
rule 'MD035', style: '---'
