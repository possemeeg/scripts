#!/bin/bash

export hello="hellosd"
((read -n1 -t2 -p'X? (i)3, (K)DE, (n)one:' ANS && [ "$ANS" == "n" ]) || (export X_INIT_PARAM="$ANS" && export ANS && echo "1$ANS, 2$X_INIT_PARAM" && echo "startx $X_INIT_PARAM"))
echo $hello
