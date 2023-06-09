-- Empty string constant
""				

-- Normal escape
"ag\a\g\\a\\g"		

-- Special escape
"ntbf\n\t\b\f\\n\\t\\b\\f"	

-- Null escape. Should be "1230"	
"123\0"				

-- Null escape. Should be "1230123"
"123\0123"		    

-- Null escape. Should be "123\0"
"123\\0"			

-- Null escape. Should be "123\0123"
"123\\0123"		    

-- Slash escape. Should be "123\0"
"123\\\0"			

-- Slash escape. Should be "123\\0"
"123\\\\0"

-- "\\n"
"\\n"

-- "\\\n"
"\\\n"

-- Error: String contains null character
"hello world"		

-- Error: String contains escaped null character
"hello\ world"
		
-- Error: String too long
"I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss I am your boss "

-- Test in manual
"This \
is OK"

"This is not
OK"

-- Unmatched '*)'
(*This is a comment*)*)

Class H inherits A {
   c() : Int {
      let num2 : Int <- 1, Error in (2+1)
   };

   d() : Int {
      let Error, num2 : Int <- 1 in (2+1)
   };
};

-- EOF in string constant
" abc