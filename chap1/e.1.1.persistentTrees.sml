type key = string
(* datatype tree =  LEAF | TREE of tree * key * tree *)

datatype 'a tree = LEAF  | TREE of  'a * 'a tree * key *  'a  tree;

(* val empty = LEAF *)

fun insert (ke:key, value: 'a ,LEAF) = TREE (value ,LEAF , ke, LEAF)
    | insert (ke:key,value: 'a,  TREE(v,l,k,r)) = 
        if ke <  k
            then TREE(value, insert(ke,value , l), k,  r)
        else if ke > k
            then TREE(value, l, k, insert(ke,value, r))
        else TREE(value , l, ke, r)


(* fun member (ke:key , LEAF)  =  false
    | member(ke:key, TREE(l,k,r)) = 
        if ke < k 
            then member(ke, l) 
        else if ke > k
            then member(ke, r)
        else
            true *)

exception NotFound
fun lookup ( ke:key ,LEAF) = raise NotFound
    | lookup (ke:key, TREE(v, l,k,r)) = 
        if ke<  k 
            then lookup(ke, l)
        else if ke >  k 
            then lookup(ke, r)
        else 
            v



val test_tree2 =   TREE(1,LEAF, "f", LEAF)
val test_tree3 = insert("e",3,test_tree2)
val lookup_ans = lookup("f",test_tree2)
val ans_lookup = lookup("e",test_tree3)


