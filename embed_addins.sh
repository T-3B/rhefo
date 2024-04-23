#!/bin/bash

find addins -mindepth 1 -type d -printf %P\\0 | parallel -0 '{ sed "/^#EOF#$/q" rhefo; find addins/{} -mindepth 1 -printf %P\\n | tar c -b1 -C./addins/{}/ -T- | base64 -w600;} >rhefo_{}; chmod +x rhefo_{}'
