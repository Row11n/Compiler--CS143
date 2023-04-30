class A {
ana(): Int {
(let x:Int <- 1 in 2)+3
};
};

Class BB__ inherits A {
};


class ListNode 
{
   str : String;
   nxt : ListNode;
   push(s : String, n : ListNode) : ListNode 
   {
      {
         str <- s;
         nxt <- n;
         self;
      }
   };

   next() : ListNode 
   {
      nxt
   };

   val() : String 
   {
      str
   };
};

class Stack 
{
   top: ListNode;

   push(s : String) : Stack 
   {
      {
         top <- (new ListNode).push(s, top);
         self;
      }
   };

   pop() : Stack 
   {
         if (isvoid top) then
            self
         else
         {
            top <- top.next();
            self;
         }fi
   };

   top() : ListNode 
   {
      top
   };
};

class DCommand {

   io : IO <- new IO;
   display(sta : Stack) : Object 
   {
      let
         p : ListNode <- sta.top()
      in
         {
            while (not isvoid p) loop 
            {
               io.out_string(p.val().concat("\n"));
               p <- p.next();
            }pool;
            self;
         }
   };
};

class ECommand {
   str1 : String;
   str2 : String;
   aoi : A2I <- new A2I;

   execute(sta : Stack) : Object 
   {
      {
         if (isvoid sta.top()) then
            self
         else
         {
            str1 <- sta.top().val();
            if (str1 = "+") then
            {
               sta.pop();
               str1 <- sta.top().val();
               sta.pop();
               str2 <- sta.top().val();
               sta.pop();
               sta.push(aoi.i2a(aoi.a2i(str1) + aoi.a2i(str2)));
            }
            else
               if (str1 = "s") then
               {
                  sta.pop();
                  str1 <- sta.top().val();
                  sta.pop();
                  str2 <- sta.top().val();
                  sta.pop();
                  sta.push(str1);
                  sta.push(str2);
               }
               else
                  self
               fi
            fi;
         }fi;
      }
   };
};

class Main inherits IO 
{
   sta : Stack <- new Stack;
   flag : Bool;
   cmd: String;

   main() : Object 
   {
      {
         flag <- true;
         while (flag) loop 
         {
            out_string(">");
            cmd <- in_string();
            if (cmd = "x") then
               flag <- false
            else
               if (cmd = "d") then
                  (new DCommand).display(sta)
               else
                  if (cmd = "e") then
                     (new ECommand).execute(sta)
                  else
                     sta.push(cmd)
                  fi
               fi
            fi;
         }
         pool;
      }
   };
};

Class FeaturesTest inherits IO {

   bool_1 : Bool;
   bool_2 : Bool <- true;
   n1 : Int <- 1;
   n2 : Int <- n1 * 2 + 3;
   n3 : Int <- n1 * (2 + 3);
   
   test1(str2: String) : Int {
   	out_string("ccyytt")
   };
   test2() : String {
   	if not isvoid n1 then out_string("ccyytt") else out_string("ccyytt") fi
   };
   test3() : Object {
    case 1=2 of
        b1 : Bool => true;
    esac
    };
   test4() : Object {
    case 1=2 of
        b1 : Bool => true;
        b2 : Int => 1;
    esac
    };
   test5() : SELF_TYPE {
    while ~n1 < 10 loop self pool
   };
   test6() : Object {
      { n1;
        n2;
      }
   };
   test7_let() : Object {
       let n1 : Int in {
            n1 <- n1 + 3;
       }
   };
   test8_let() : Object {
       let n1 : Int <- 3 in {
            n1 <- n1 + 4;
       }
   };
   test9_let() : Object {
       let n1 : Int <- 3,
           n2 : Int <- 4 in {
           n1 <- n1 + n2;
       }
   };
   let10_let() : Object {
       let n1 : Int,
           n2 : Int in {
           n1 <- n1 + n2;
       }
   };
   let11_let() : Object {
       let n1 : Int in n1 + 2
   };

};

Class TypeTest inherits FeaturesTest {
   bool_1_2 : Bool <- true;
   bool_2_2 : Bool <- not bool1_2;
   
   n1 : Int <- 1;
   n2 : Int <- ~n1;

   str : String <- "This is ccyytt";
   
   newInstance1 : FeaturesTest <- new FeaturesTest;
   newInstance2 : FeaturesTest;
   obj : Object <- newInstance1;
   voidTest : Bool <- isvoid newInstance2;
};
