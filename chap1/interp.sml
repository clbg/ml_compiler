use "slp.sml";

type table  =  (id* int )list;



fun update(t, c, i)  = (c,i):: t;
fun lookup ((c,i)::ts, cc)  =  if ( c = cc) then (i)  else lookup(ts,cc);


fun applyOP (Plus, o1,o2) =  o1+o2
        | applyOP(Minus,o1,o2) = o1-o2
        | applyOP(Times, o1,o2) = o1*o2
        | applyOP(Div, o1,o2)  =  o1 div o2


(* test for update and lookup
val c =[("fd", 1),("b",3)];
val cccc = lookup ( c ,"b")
val c = update(c , "b", 2)
val cccccc = lookup ( c ,"b")
*)

(*interp: stm->unit*)


(* todo : unit return  *)

(*interpStm: stm*table -> table *)
(*interpExp: exp*table - >  int *table *)

(* todo : print *)
fun      interpStm  (CompoundStm( left, right), t) =  interpStm(right, interpStm(left,t))
        |interpStm(AssignStm (id, exp), t) = let val (value,t2) = interpExp(exp,t) in update(t2,id,value) end
        (* |interpStm(PrintStm (exp::explist) , t) =  if explist = nil then #2 interpExp(exp,t) else interpStm(explist,(# 2 interpExp(exp,t))) *)
        |interpStm(PrintStm (exp::explist) , t) = 
                let val (value,tt) = interpExp(exp,t) in 
                        if explist = nil then 
                                (print("out:");print(Int.toString value); print("\n") ;tt)
                        else 
                                (print("out:");print(Int.toString value); print("\n") ;interpStm (PrintStm(explist), tt) )
                end
and 
         interpExp (IdExp(id), t )  =   (lookup(t,id),t)
	|interpExp (NumExp(s),t) = (s,t)
	|interpExp (OpExp (e1,biop,e2),t)= 
                (let val (value1,t1) = interpExp(e1,t) in 
                        let val (value2,t2) = interpExp(e2,t1) in
                                (applyOP( biop,value1,value2) ,t2)
                        end
                end)
	|interpExp (EseqExp(stm,exp),t) = let val  stmtable  = interpStm(stm, t) in interpExp(exp,stmtable)  end;


fun interp(stm) = let  val emptytable = [] in (interpStm(stm, emptytable); () )end ;


val ans = interp(prog)

