(*
 *  CS164 Fall 94
 *
 *  Programming Assignment 1
 *    Implementation of a simple stack machine.
 *
 *  Skeleton file
 *)

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