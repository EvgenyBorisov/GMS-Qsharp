///Qtest(file);
//var QVM=Qvm_create("Qvm",Qprint_to_console,Qprint_error_to_console);
with QVM {
    
    
    var i;
    var token,token_tp;
    
    
    var tokens=Qload_tokens_from_string(argument0);
    var token_list=ds_list_find_value(tokens,0);
    var token_list_tp=ds_list_find_value(tokens,1);
    
    Qscr_print("Before: ");
    for (i=0; i<ds_list_size(token_list);i++){
            Qscr_print(string(token_list_tp[| i]) + ": "+ string(token_list[| i]));
    }
    
    
    
    var bytecode=Qcreate_bytecode(tokens);
    var after=ds_list_find_value(bytecode,0);
    var after_tp=ds_list_find_value(bytecode,1);
    
    Qscr_print("After: ");
    for (i=0; i<ds_list_size(after);i++){
            Qscr_print(string(after_tp[| i]) + ": "+ string(after[| i]));
    }
        
         
    Qscr_print("Result: ");
    Qvm_execute(bytecode);
    //Qscr_print(ds_stack_size(stack));
    
    //Qscr_print(string(ds_stack_top(stack)));
    //show_debug_message(5/3);
}

