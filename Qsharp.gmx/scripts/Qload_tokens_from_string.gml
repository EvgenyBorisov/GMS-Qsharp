//var file = file_text_open_read(argument0);
var str=argument0;

/*while (!file_text_eof(file)){
    ds_list_add(str, file_text_readln(file));
}*/
        
var token_list=ds_list_create();
var token_list_tp=ds_list_create();
var list;
var list_tp;
var result=ds_list_create();


    var l=Qparse(str);
    list=ds_list_find_value(l,0);
    list_tp=ds_list_find_value(l,1);
    for (j=0; j<ds_list_size(list);j++){
        ds_list_add(token_list,list[|j]);
        ds_list_add(token_list_tp,list_tp[|j]);
    }

ds_list_add(result,token_list);
ds_list_add(result,token_list_tp);
//ds_list_mark_as_list(list, 0);
//file_text_close(file);
//ds_list_destroy(str);
ds_list_destroy(list);
ds_list_destroy(list_tp);
//ds_list_destroy(token_list);
//ds_list_destroy(token_list_tp);
return result;
