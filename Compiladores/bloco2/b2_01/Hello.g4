grammar Hello;
r: (greetings | bye)+;
greetings : 'hello' name  ;
bye: 'bye' name ;
name: ID;
ID : [a-z]+ ;
WS : [ \t\r\n]+ -> skip;
