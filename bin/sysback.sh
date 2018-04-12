#!/bin/bash

pacman -Qii | awk '/^MODIFIED/ {print $2}'|xargs -I file rsync -aRv file ~/etcback/
