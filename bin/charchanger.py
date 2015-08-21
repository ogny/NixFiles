#!/usr/bin/env python

  replaceDict={'\xc3\xbd':'i','\xc3\xb0':'g','\xc3\xbe':'s','\xc3\xa2':'a','\xc3\xa7':'c','\xc3\xb6':'o','\xc3\xbc':'u','\xc3\xae':'i'}
  for key, replacement in replaceDict.items():  
    my_string = my_string.replace( key, replacement )
