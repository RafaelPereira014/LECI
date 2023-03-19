grammar SuffixCalculator;
program:
    stat* EOF
    ;        //zero or more rep of stat
stat:
    expr? NEWLINE
    ;
expr:
    expr expr op=('*'|'/'|'+'|'-')
    | Number
    ;
Number: [0-9]+('.'[0-9]+)?; //0 or more rep of 0-9, followed by a dot, followed by 0 or more rep of 0-9
NEWLINE: '\r'? '\n'; //optional \r, followed by \n
WS: [ \t]+ -> skip; //0 or more rep of space or tab, skip