var after=ds_list_find_value(argument0,0);
var after_tp=ds_list_find_value(argument0,1);

var a1,a2,a3,a4,a5;
var a1_tp,a2_tp,a3_tp,a4_tp,a5_tp;

//stack=ds_stack_create();
//stack_tp=ds_stack_create();
for (i=0; i<ds_list_size(after);i++){
    //Qscr_print(string(after_tp[| i]) + ": "+ string(after[| i]));
    if (after_tp[| i]==TP_OPERATOR){ //or (after_tp[| i]==TP_FUNCTION){
    switch OPERATOR[# after[| i],OPERATOR_ARG_COUNT] {
           case 2:
                a2=real(ds_stack_pop(stack));
                a2_tp=ds_stack_pop(stack_tp);
                a1=real(ds_stack_pop(stack));
                a1_tp=ds_stack_pop(stack_tp);
                if (a1_tp==TP_DIGIT) and (a2_tp==TP_DIGIT){
                   switch after[| i] {
                          case 1: // +
                               ds_stack_push(stack,a1+a2);
                          break;
                          case 2: // -
                               ds_stack_push(stack,a1-a2);
                          break;
                          case 3: // *
                               //show_debug_message(a1);
                               //show_debug_message(a2);
                               ds_stack_push(stack,a1*a2);
                          break;
                          case 4: // /
                               if a2==0 {Qerror("/0 detected")}
                               ds_stack_push(stack,a1/a2);
                          break;
                          case 5: // %
                               if a2==0 {Qerror("/0 detected in operator %")}
                               ds_stack_push(stack,a1%a2);
                          break;
                          default:
                                  Qerror("Unexpected operator in runtime:" + string(after[| i]));
                   }
                   ds_stack_push(stack_tp,TP_DIGIT);
                }
                break;
           }
    }else if (after_tp[| i]==TP_FUNCTION){ //or (after_tp[| i]==TP_FUNCTION){
          switch FUNCTION[# after[| i],FUNCTION_ARG_COUNT] {
                 case 0:
                      //ds_stack_pop(stack_tp);
                      script_execute(FUNCTION[# after[| i],FUNCTION_SCRIPT]);
                 break;
                 case 1:
                      ds_stack_pop(stack_tp);
                      script_execute(FUNCTION[# after[| i],FUNCTION_SCRIPT],ds_stack_pop(stack));
                 break;
                 case 2:
                      a2=real(ds_stack_pop(stack));
                      a2_tp=ds_stack_pop(stack_tp);
                      a1=real(ds_stack_pop(stack));
                      a1_tp=ds_stack_pop(stack_tp);
                      script_execute(FUNCTION[# after[| i],FUNCTION_SCRIPT],a1,a2);
                 break;
                 default:
                         Qerror("Function with "+string(FUNCTION[# after[| i],FUNCTION_ARG_COUNT])+" argument count not supported now.")
                 break;
          }
    }
    else{
         ds_stack_push(stack,after[| i]);
         ds_stack_push(stack_tp,after_tp[| i]);
    } 
}
ds_stack_clear(stack);
ds_stack_clear(stack_tp);
