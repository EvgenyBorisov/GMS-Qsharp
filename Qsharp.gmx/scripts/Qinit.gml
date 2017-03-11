///Qinit();
OPERATORS_COUNT=12;
OPERATOR=ds_grid_create(OPERATORS_COUNT,4);

Qadd_operator(0,"=",OPTP_RS,15,2);
Qadd_operator(1,"+",OPTP_LS,6,2);
Qadd_operator(2,"-",OPTP_LS,6,2);
Qadd_operator(3,"*",OPTP_LS,5,2);
Qadd_operator(4,"/",OPTP_LS,5,2);
Qadd_operator(5,"%",OPTP_LS,5,2);
Qadd_operator(6,"(",OPTP_SPECIAL,100,0);
Qadd_operator(7,")",OPTP_SPECIAL,100,0);
Qadd_operator(8,",",OPTP_SPECIAL,100,0);
Qadd_operator(9,";",OPTP_SPECIAL,100,0);
Qadd_operator(10,"{",OPTP_SPECIAL,100,0);
Qadd_operator(11,"}",OPTP_SPECIAL,100,0);

FUNCTIONS_COUNT=4;
FUNCTION=ds_grid_create(FUNCTIONS_COUNT,10);
Qadd_function(0,"print",TP_VOID,1,Qscr_print,TP_STRING,TP_UNKNOWN,TP_UNKNOWN,TP_UNKNOWN,TP_UNKNOWN,TP_UNKNOWN);
Qadd_function(1,"print_error",TP_VOID,1,Qscr_print_error,TP_STRING,TP_UNKNOWN,TP_UNKNOWN,TP_UNKNOWN,TP_UNKNOWN,TP_UNKNOWN);
Qadd_function(2,"exp",TP_DIGIT,1,Qscr_exp,TP_DIGIT,TP_UNKNOWN,TP_UNKNOWN,TP_UNKNOWN,TP_UNKNOWN,TP_UNKNOWN);
Qadd_function(3,"power",TP_DIGIT,2,Qscr_power,TP_DIGIT,TP_DIGIT,TP_UNKNOWN,TP_UNKNOWN,TP_UNKNOWN,TP_UNKNOWN);
