#!/bin/sh

pacman -Scc --noconfirm && pacman -Syu && pacman -Qu | wc -l
