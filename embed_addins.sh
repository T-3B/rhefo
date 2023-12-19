#!/bin/bash

find addins -mindepth 1 -type d -printf %P\\0 | parallel -0 '{ sed "/^#EOF#$/q" rhefo; find addins/x86-64/ -mindepth 1 -printf %P | tar c -b1 -C./addins/x86-64/ -T- | base64 -w600;} >rhefo_{}'
