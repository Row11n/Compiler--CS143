/*
 *  The scanner definition for COOL.
 */

%option noyywrap

/*
 *  Stuff enclosed in %{ %} in the first section is copied verbatim to the
 *  output, so headers and global definitions are placed here to be visible
 * to the code in the file.  Don't remove anything that was here initially
 */
%{
#include <cool-parse.h>
#include <stringtab.h>
#include <utilities.h>

/* The compiler assumes these identifiers. */
#define yylval cool_yylval
#define yylex  cool_yylex

/* Max size of string constants */
#define MAX_STR_CONST 1025
#define YY_NO_UNPUT   /* keep g++ happy */

extern FILE *fin; /* we read from this file */

/* define YY_INPUT so we read from the FILE fin:
 * This change makes it possible to use this scanner in
 * the Cool compiler.
 */
#undef YY_INPUT
#define YY_INPUT(buf,result,max_size) \
	if ( (result = fread( (char*)buf, sizeof(char), max_size, fin)) < 0) \
		YY_FATAL_ERROR( "read() in flex scanner failed");

char string_buf[MAX_STR_CONST]; /* to assemble string constants */
char *string_buf_ptr;

extern int curr_lineno;
extern int verbose_flag;

extern YYSTYPE cool_yylval;

/*
 *  Add Your own definitions here
 */
# include<string.h>
using namespace std;
static int stack_comment = 0;

%}

/*
 * Define names for regular expressions here.
 */

%x INLINE_COMMENT NESTED_COMMENT STRING

DIGIT   [0-9]+
DARROW    =>
ASSIGN    <-
LE        <=
TYPEID    [A-Z][a-zA-Z0-9_]*
OBJECTID  [a-z][a-zA-Z0-9_]*

%%

 /*
  *  Inline comment
  */
<INITIAL>"--"   BEGIN(INLINE_COMMENT);

<INLINE_COMMENT>[^\n]* {}

<INLINE_COMMENT>[\n]   {
  curr_lineno ++;
  BEGIN(0);
}

 /*
  *  Nested comment
  */
<INITIAL>"*)"   {
  cool_yylval.error_msg = "Unmatched *)";
  return ERROR;
}

<INITIAL,NESTED_COMMENT>"(*"  {
  stack_comment++;
  BEGIN(NESTED_COMMENT);
}

<NESTED_COMMENT>"\n"    curr_lineno ++;

<NESTED_COMMENT>"*)"  {
  stack_comment--;
  if (stack_comment == 0)
      BEGIN(0);
}

<NESTED_COMMENT><<EOF>>  {
  cool_yylval.error_msg = "EOF in comment";
  BEGIN(0);
  return ERROR;
}

<NESTED_COMMENT>. {}

 /*
  *  String constants (C syntax)
  *  Escape sequence \c is accepted for all characters c. Except for 
  *  \n \t \b \f, the result is c.
  *
  */
<INITIAL>\" {
  BEGIN(STRING);
  yymore();
}

<STRING><<EOF>>   {
  cool_yylval.error_msg = "EOF in string constant";
  BEGIN(0);
  yyrestart(0);
  return ERROR;
}

<STRING>[^\"\\\n]* yymore();

<STRING>\\[^\n] yymore();

<STRING>\\\n    {
  curr_lineno ++;
  yymore();
}

<STRING>\n    {
  cool_yylval.error_msg = "Unterminated string constant";
  curr_lineno++;
  BEGIN(0);
  return ERROR;
}

<STRING>\"    {
  string raw_str(yytext, yyleng);
  raw_str = raw_str.substr(1, raw_str.length() - 2);
  string::size_type p;

  if ((p = raw_str.find_first_of('\0')) != string::npos) 
  {
      int temp = 0;
      while(raw_str[--p] == '\\')
        temp++;
      if(temp % 2)
        cool_yylval.error_msg = "String contains escaped null character.";
      else
        cool_yylval.error_msg = "String contains null character.";
      BEGIN(0);
      return ERROR;
  }

  string str = "";
  string::size_type q;
  while ((q = raw_str.find_first_of("\\")) != std::string::npos) 
  {
      str += raw_str.substr(0, q);
      switch(raw_str[q + 1]) 
      {
          case 'b':
          str += "\b";
          break;

          case 't':
          str += "\t";
          break;

          case 'n':
          str += "\n";
          break;

          case 'f':
          str += "\f";
          break;

          default:
          str += raw_str[q + 1];
          break;
      }
      raw_str = raw_str.substr(q + 2, raw_str.length() - 2);
  }

  str += raw_str;

  if (str.length() >= MAX_STR_CONST) 
  {
      cool_yylval.error_msg = "String constant too long";
      BEGIN(0);
      return ERROR;
  }

  cool_yylval.symbol = stringtable.add_string((char *)str.c_str());
  BEGIN(0);
  return STR_CONST;
}


 /*
  *  Operators.
  */
{DARROW}	{ return (DARROW);   }
{ASSIGN}    {  return (ASSIGN);  }
{LE}        {  return (LE);      }
"<"         {  return int('<');  }
"="         {  return int('=');  }
"+"         {  return int('+');  }
"-"         {  return int('-');  }
"*"         {  return int('*');  }
"/"         {  return int('/');  }
"@"         {  return int('@');  }
"{"         {  return int('{');  }
"}"         {  return int('}');  }
"~"         {  return int('~');  }
";"         {  return int(';');  }
"."         {  return int('.');  }
","         {  return int(',');  }
"("         {  return int('(');  }
")"         {  return int(')');  }
":"         {  return int(':');  }

 /*
  * Keywords are case-insensitive except for the values true and false,
  * which must begin with a lower-case letter.
  */
(?i:class)  return CLASS;
(?i:else)  return ELSE;
(?i:fi)  return FI;
(?i:if)  return IF;
(?i:in)  return IN;
(?i:inherits)  return INHERITS;
(?i:isvoid)  return ISVOID;
(?i:let)  return LET;
(?i:loop)  return LOOP;
(?i:pool)  return POOL;
(?i:then)  return THEN;
(?i:while)  return WHILE;
(?i:case)  return CASE;
(?i:esac)  return ESAC;
(?i:new)  return NEW;
(?i:of)  return OF;
(?i:not)  return NOT;
t(?i:rue)   {
  cool_yylval.boolean = true;  
  return BOOL_CONST;
}
f(?i:alse)    {
  cool_yylval.boolean = false; 
  return BOOL_CONST;
}

 /*
  *  Others
  */
{DIGIT}   {
  cool_yylval.symbol = inttable.add_string(yytext);
  return INT_CONST;
}
{OBJECTID}    {
  cool_yylval.symbol = idtable.add_string(yytext);
  return OBJECTID;
}
{TYPEID}    {
  cool_yylval.symbol = idtable.add_string(yytext);
  return TYPEID;
}
[ \t\r\f\v]+    {}
\n    curr_lineno++; 

. {
    cool_yylval.error_msg = yytext;
    return ERROR;
}
%%
