#!/bin/sh

cd datapack
mcb -build
cd ..

zip wing-chutes-datapack -r datapack/data datapack/pack.mcmeta

zip wing-chutes-resourcepack -r resourcepack/assets resourcepack/pack.png resourcepack/pack.mcmeta
