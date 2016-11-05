# RPN-Scheme-

The program is a calculator written in Scheme. It allows to calculate inputs in RPNotation.

Used functions are :-

1) Repl: A function that runs to infinity to read data input on command line.
2) Traiter-ligne : Called by Repl that does the following :
	a) Convert the data entry to a list of characters Ex :- ( "3 3 + " -> ( #\3 #\space #\3 #\space #\+ ) )
	b) calls Traiter function with two parameters, the list of characters and an empty list that represents our dictionary which 
	is an association that converts all the user input.

3)Traiter : The core function, it browses our list of characters, tests each character to know if we found an affection, a number, operator or an invalid expression.

4) Del : Deletes an element from the list.
5) Convert : To convert a number to a list of chars.


Behavior :


How to run :

The program was implemented using Racket and Gambit.

To install Gambit, please refer to http://gambitscheme.org or

Quick-install instructions for a typical installation
=====================================================

    git clone https://github.com/gambit/gambit.git
    cd gambit
    ./configure
    make -j4 latest-release
    ./configure --enable-single-host
    make -j4 from-scratch
    make check
    sudo make install
	
