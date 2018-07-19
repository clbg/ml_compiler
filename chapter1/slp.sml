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


(*
fun maxarg_exp (IdExp(id))= 0
	| maxarg_exp( NumExp (it)) = 0
	| maxarg_exp (OpExp (e,bi,e2)) = maxOfTwo (maxarg_exp(e) ,maxarg_exp(e2))
	| maxarg_exp (EseqExp(st,ex)) = maxOfTwo (maxarg_exp(ex), maxarg_stm(st))



fun maxarg_stm (CompoundStm (l,r)) = maxOfTwo ( maxarg_stm(l), maxarg_stm(r))
	| maxarg_stm(AssignStm(id,exp)) = maxarg_exp(exp)
	| maxarg_stm(PrintStm(l)) = len(l)


val aa = maxarg_stm(prog)
*)
fun maxarg (CompoundStm (left,right))=  maxOfTwo (maxarg(left), maxarg(right)) 
	| maxarg (AssignStm (id,exp))  = maxarg(exp)
	| maxarg (PrintStm (explist)) =  len(explist)
	| maxarg (IdExp(id))  =  0
	| maxarg (NumExp(t)) = 0
	| maxarg (OpExp (e1,biop,e2))= maxOfTwo( maxarg(e1), maxarg(e2))
	| maxarg (EseqExp (stm, exp) )= maxOfTwo( maxarg(stm), maxarg(exp))


val ans= maxarg(prog) 


