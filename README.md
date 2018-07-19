# ml_compiler

compiler project for Appel_A_W Modern Compiler Implementation write in standard ml


using sml new jersey


[excercises source code](http://www.cs.princeton.edu/~appel/modern/ml/project.html)

## build up 
[sml dev setup](https://blog.jez.io/sml-dev-setup/)



## learn ml
[fit](https://cs.fit.edu/~ryan/sml/intro.html)


## notes

### chapter 1

#### maxarg
failed several times to finish, because type of stm and exp can't be correctly handled in one function, when I used pattern matching, sml tells me "|" splitted function should have the same type, but I gave both "exp -> 'Z" and "stm -> 'Z" the same time.

then I tired to define two seperate function maxarg_stm, maxarg_exp then failed either, becases these functions have mutually recersions.

the solution to this problem is "simultaneously declaretion". using and keyword, these functions are defined at the same time. 
