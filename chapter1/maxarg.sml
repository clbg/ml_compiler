use "slp.sml";
fun maxOfTwo (a, b) = 
	if a > b then a else 
	b

val lis= [1,2,3,4,55,3,1000,4,3,6,7]


val max =foldl maxOfTwo 0  lis

fun len (x::xs) = 1+len(xs) 
	| len []= 0

fun maxarg_stm (CompoundStm (left,right))=  maxOfTwo (maxarg_stm(left), maxarg_stm(right)) 
	| maxarg_stm (AssignStm (id,exp))  = maxarg_exp(exp)
	| maxarg_stm (PrintStm (explist)) =  maxOfTwo ( 
		len(explist),
		foldl maxOfTwo 0 ( map maxarg_exp explist)
	)
and 
	 maxarg_exp (IdExp(id))  =  0
	| maxarg_exp  (NumExp(t)) = 0
	| maxarg_exp (OpExp (e1,biop,e2))= maxOfTwo( maxarg_exp(e1), maxarg_exp(e2))
	| maxarg_exp (EseqExp (stm, exp) )= maxOfTwo( maxarg_stm(stm), maxarg_exp(exp))



val ans= maxarg_stm(prog) 


(*Eror Code: parameter or result constraints of cluases  do not agree [tycon mismatch]

stm --> 'z
exp --> 'z

refers:

http://flint.cs.yale.edu/cs421/smlnj/doc/errors.html

solution:

simultaneous declaretion


parameter or result constraints of clauses don't agree
In a fun declaration, each clause, or rule, separated by | (vertical bar symbol), has to have the same type (both in the type accepted by the clauses, and the type returned by the clauses).
  datatype typeA = A;
  datatype typeB = B;
  fun f A = 0
    | f B = 0;
  stdIn:36.1-37.12 Error: parameter or result constraints of clauses don't agree [tycon mismatch]
    this clause:      typeB -> 'Z
    previous clauses:      typeA -> 'Z
    in declaration:
      f =
	(fn A => 0
	  | B => 0)
*)

(*
fun maxarg (CompoundStm (left,right))=  maxOfTwo (maxarg(left), maxarg(right)) 
	| maxarg (AssignStm (id,exp))  = maxarg(exp)
	| maxarg (PrintStm (explist)) =  len(explist)
	| maxarg (IdExp(id))  =  0
	| maxarg (NumExp(t)) = 0
	| maxarg (OpExp (e1,biop,e2))= maxOfTwo( maxarg(e1), maxarg(e2))
	| maxarg (EseqExp (stm, exp) )= maxOfTwo( maxarg(stm), maxarg(exp))
*)



