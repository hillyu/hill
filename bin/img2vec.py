#!/usr/bin/env python
# -*- coding: utf-8 -*-

from PIL import Image
from PIL import ImageOps
import sys
import numpy as np
size = 64, 64
args=sys.argv
if len(args) > 1:
    img_file = args[1]
else: exit()
img = Image.open(img_file)
img=img.resize(size,Image.ANTIALIAS)
img=ImageOps.invert(img)
img=img.convert('1', dither=None)
img_vec=np.array(img)
# img_vec[img_vec !=0] = 1
packed_str=''.join(np.packbits(img_vec.reshape(64*64)).astype(str))
packed_binary=np.packbits(img_vec.reshape(64*64)).tobytes()
with open(img_file.replace('.png','.bin'), 'wb') as f:
    f.write(packed_binary)
# print (packed_str)
packed_arr=np.frombuffer(packed_binary,dtype="uint8")
# print (packed_arr,len(packed_arr))
print (','.join(np.unpackbits(packed_arr).astype(str)))
