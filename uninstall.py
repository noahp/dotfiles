#!/usr/bin/env python
"""
Uninstall script.
Shamelessly copied from:
https://github.com/anishathalye/dotbot/issues/152#issuecomment-394129600
"""
from __future__ import print_function

import yaml
import os

CONFIG="install.conf.yaml"

stream = open(CONFIG, "r")
conf = yaml.load(stream)

for section in conf:
    if 'link' in section:
        for target in section['link']:
            realpath = os.path.expanduser(target)
            if os.path.islink(realpath):
                print("Removing ", realpath)
                os.unlink(realpath)
