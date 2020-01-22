#!/bin/bash
try() {
    expected="$1"
    input="$2"

    ./9cc "$input" > tmp.s
    gcc -o tmp tmp.s
    ./tmp
    actual="$?"

    if [ "$actual" = "$expected" ]; then
        echo "$input => $actual"
    else
        echo "$input => $expected expected, but got $actual"
        exit 1
    fi
}

try 0 0
try 42 42
try 21 "5+20-4"
try 41 " 12 + 34 - 5 "
try 47 "5+6*7"
try 15 "5*(9-6)"
try 4 "(3+5)/2"
try 5 "-5+10"
try 5 "-(-5)"
try 4 "11*(-6)+70"
try 1 "10/(-5)+3"
try 1 "1==1"
try 0 "1==2"
try 1 "10!=100"
try 0 "100!=100"
try 1 "-1!=+1"
try 1 "0<5"
try 0 "5<5"
try 0 "7<3"
try 1 "-10<13"
try 1 "18<=30"
try 1 "10<=10"
try 0 "10<=9"
try 1 "-5<=-5"
try 1 "6>1"
try 0 "9>9"
try 0 "41>55"
try 1 "41>-55"
try 1 "99>=62"
try 1 "77>=77"
try 0 "81>=128"
try 1 "-5>=-5"

echo OK
