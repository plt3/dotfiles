#!/bin/bash

latest=$(ls -t | head -n1)
g++ -std=c++11 $latest
./a.out
rm a.out
