
(*
 *  execute "coolc bad.cl" to see the error messages that the coolc parser
 *  generates
 *
 *  execute "myparser bad.cl" to see the error messages that your parser
 *  generates
 *)

(* no error *)
class A {
};

(* error:  b is not a type identifier *)
Class b inherits A {
};

(* error:  a is not a type identifier *)
Class C inherits a {
};

(* error:  keyword inherits is misspelled *)
Class D inherts A {
};

(* error:  closing brace is missing *)
Class E inherits A {
;

(* error:  TYPEID is wrong *)
Class F {
	n : Int;
	m : Int <- ERROR;
};

(* error:  missiong ';' *)
Class G inherits A {
    n : Int <- 10
};

Class G2 inherits A {
    n : Int <- 10;
}

(* error:  multiple block *)
Class H {
 	mult(num1 : Int) : Int {
      { 
         umn1 <- 1; 
         Error; 
      }
  };
};

(* error:  let errors *)
Class I {
   f() : Int {
      let f : Int <- 1, ERROR in (2+1)
   };

   u() : Int {
      let ERROR, u : Int <- 1 in (2+1)
   };

   d() : Int {
      let d <- , ERROR: Int <- 1 in (2+1)
   };

   a() : Int {
      let a : Int <- 1 in (2+1);
   };

   n() : Int {
      let n, ERROR : Int <- 1 in (2+1)
   };
};

(* error:  case error *)
Class J {
   x : Int <- n case of s : String => 0 esac;
};

(* error:  string error *)
Class K {
   c() : Object {
      out_string(ERROR);
   }
};

