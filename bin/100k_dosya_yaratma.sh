#!/bin/bash
for n in {1..100}; do dd if=/dev/zero of=file$( printf %03d "$n" ).bin bs=1024 count=100; done
