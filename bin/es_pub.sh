#!/usr/bin/env bash
cd $HOME/website/hugo/everstream/
hugo && rsync -avz --delete public/ nas:/var/www/website/EverStream/
