#!/usr/bin/env python3
"""
Uninstall script.
Shamelessly copied from:
https://github.com/anishathalye/dotbot/issues/152#issuecomment-394129600
"""
import os

import yaml

CONFIG = "install.conf.yaml"

stream = open(CONFIG, "r")
conf = yaml.safe_load(stream)

for section in conf:
    if "link" in section:
        for target in section["link"]:
            realpath = os.path.expanduser(target)
            if os.path.islink(realpath):
                print("Removing ", realpath)
                os.unlink(realpath)
