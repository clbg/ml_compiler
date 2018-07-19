type id = string

datatype binop = Plus | Minus | Times | Div

datatype stm = CompoundStm of stm * stm
	     | AssignStm of id * exp
	     | PrintStm of exp list

     and exp = IdExp of id
	     | NumExp of int
             | OpExp of exp * binop * exp
             | EseqExp of stm * exp
val prog = 
 CompoundStm(AssignStm("a",OpExp(NumExp 5, Plus, NumExp 3)),
  CompoundStm(AssignStm("b",
      EseqExp(PrintStm[IdExp"a",OpExp(IdExp"a", Minus,NumExp 1)],
           OpExp(NumExp 10, Times, IdExp"a"))),
   PrintStm[IdExp "b"]))

fun maxOfTwo (a, b) = 
	if a > b then a else 
	if a < b then b else 
	a

val lis = [1,2,3,4,5,6,7,8,9]


fun len (x::xs) = 1+len(xs) 
	| len []= 0

val ans = len (lis)

(*Eror Code: parameter or result constraints of cluases  do not agree [tycon mismatch]

stm --> 'z
exp --> 'z

ansewrs:

http://flint.cs.yale.edu/cs421/smlnj/doc/errors.html


parameter or result constraints of clauses don't agree
In a fun declaration, each clause, or rule, separated by | (vertical bar symbol), has to have the same type (both in the type accepted by the clauses, and the type returned by the clauses).
  datatype typeA = A;
  datatype typeA = A
  datatype typeB = B;
  datatype typeB = B
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

val ans= maxarg(prog) 


