#!/bin/bash

readable $1 -p html-title,html-content 2>/dev/null|w3m -T text/html
