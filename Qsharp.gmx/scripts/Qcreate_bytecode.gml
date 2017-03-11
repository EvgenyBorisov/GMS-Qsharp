var after=ds_list_create();
var after_tp=ds_list_create();
var result=ds_list_create();
var tokens=argument0;

var token_list=ds_list_find_value(tokens,0);
var token_list_tp=ds_list_find_value(tokens,1);

var stack=ds_stack_create();
var stack_tp=ds_stack_create();
for (i=0; i<ds_list_size(token_list);i++){
    token=token_list[| i];
    token_tp=token_list_tp[| i];
    if (token_tp==TP_DIGIT or token_tp==TP_STRING or token_tp==TP_CHAR or token_tp==TP_VAR){
        ds_list_add(after,token);
        ds_list_add(after_tp,token_tp);
    }
    else if (token_tp==TP_FUNCTION){
        ds_stack_push(stack,token);
        ds_stack_push(stack_tp,token_tp);
    }
    else if  (token==8){  //запятая
         while (ds_stack_top(stack)!=6) and !ds_stack_empty(stack) {
               ds_list_add(after,ds_stack_pop(stack));
               ds_list_add(after_tp,ds_stack_pop(stack_tp));
         }
    }
    else if  (token==6){  //скобка (
         ds_stack_push(stack,token);
         ds_stack_push(stack_tp,token_tp);
    }
    else if  (token==7){  //скобка )
         while (ds_stack_top(stack)!=6) and !ds_stack_empty(stack) {
               ds_list_add(after,ds_stack_pop(stack));
               ds_list_add(after_tp,ds_stack_pop(stack_tp));
         }
         ds_stack_pop(stack);
         ds_stack_pop(stack_tp);
         if ds_stack_top(stack_tp)==TP_FUNCTION {
            ds_list_add(after,ds_stack_pop(stack));
            ds_list_add(after_tp,ds_stack_pop(stack_tp));
         }
    }
    else if  (token==9){  // ;
         while (!ds_stack_empty(stack)) {
               ds_list_add(after,ds_stack_pop(stack));
               ds_list_add(after_tp,ds_stack_pop(stack_tp));
         }
    }
    else if  (token_tp==TP_OPERATOR) {
         while (ds_stack_top(stack_tp)==TP_OPERATOR){
               var op1=token;
               var op2=ds_stack_top(stack);
               if ((OPERATOR[# op1,OPERATOR_TYPE] = OPTP_LS) and (OPERATOR[# op1,OPERATOR_PRIORITY] >= OPERATOR[# op2,OPERATOR_PRIORITY])) or ((OPERATOR[# op1,OPERATOR_TYPE] = OPTP_RS) and (OPERATOR[# op1,OPERATOR_PRIORITY]>OPERATOR[# op2,OPERATOR_PRIORITY])){
                  ds_list_add(after,ds_stack_pop(stack));
                  ds_list_add(after_tp,ds_stack_pop(stack_tp));
               }
               else {
                    break;
               }
         }
         ds_stack_push(stack,token);
         ds_stack_push(stack_tp,token_tp);
    }
    else {
         Qerror("Unexpected token (" + string(token_tp)+","+string(token)+")");
    }
}
if !ds_stack_empty(stack) {
   Qerror("Unexpected end of token stream");
}
ds_stack_destroy(stack);
ds_stack_destroy(stack_tp);

ds_list_add(result,after);
ds_list_add(result,after_tp);
return result;
