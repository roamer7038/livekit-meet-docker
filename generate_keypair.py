#!/usr/bin/env python3

import secrets

def generate_keypair():
    key = secrets.token_hex(16)
    secret = secrets.token_hex(16)
    return key, secret

key, secret = generate_keypair()

print(f"Key: {key}, Secret: {secret}")
