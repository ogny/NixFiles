#!/bin/bash

apt-get update && \
aptitude autoclean && \
aptitude -dy full-upgrade

