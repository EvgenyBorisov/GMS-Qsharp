///Qparse(str)
/*
**  Usage:
**      string_parse(str,token,ignore_null)
**
**  Arguments:
**      str         a string with a certain token seperating the
**                  desired substrings,  string
**      token       a string (usually a single variable) representing
**                  the character(s) that str is seperated by,  string
**      ignore_null whether or not to include empty strings if, for
**                  example, the token was repeated,  bool (true/false)
**                   
**  Returns:
**      a ds_list containing all substrings taken from str which
**      were seperated by token.
**
**  Example:
**      string_parse("cat|dog|house|bee", "|", true);
**      returns a ds_list containing "cat", "dog", "house", and "bee"
**
**  GMLscripts.com
*/
{
    var str, token,ctoken="", list,i,c,u;
    
    str = argument0;
    //token = argument1;
    //ignore = argument2;
    var list = ds_list_create();
    var tplist=ds_list_create();
    var plist = ds_list_create();
    var anlist;
    
    var is_str=0;
    var is_chr=0;
    var is_dig=0;
    var cpr="";
    
    for (i=1;i<string_length(str)+1;i++){
        c=string_char_at(str,i);
        u=ord(c);
        if (is_str==1){
            if u==34 {
                ds_list_add(plist,ctoken);
                ds_list_add(tplist,TP_STRING);
                ctoken=""; 
                is_str=0;
            }
            else {
                ctoken+=c;
            }
        }
        else if (is_chr==1){
            if u==39 {
                ds_list_add(plist,ctoken);
                ds_list_add(tplist,TP_CHAR);
                ctoken=""; 
                is_chr=0;
            }
            else {
                ctoken+=c;
            }
        }
        else {
            if (c == ' ') { 
                if ctoken!="" {
                    if (string_byte_at(ctoken,1)>=48) and (string_byte_at(ctoken,1)<=57)  {
                        ds_list_add(tplist,TP_DIGIT);
                    }
                    else {
                        ds_list_add(tplist,TP_VAR);
                    }
                    ds_list_add(plist,ctoken);
                    ctoken=""; 
                }
            }
            else if (u==34) {
                if is_str=0 {
                is_str=1;
                cpr=c;
                continue;
                }
            }
            else if (u==39) {
                if is_chr=0 {
                is_chr=1;
                cpr=c;
                continue;
                }
            }
            else if (((u>=33) and (u<=47)) or ((u>=58) and (u<=64)) or ((u>=91) and (u<=94)) or ((u>=123) and (u<=126))) {//(c==',') or (c=='(') or (c==')')or (c=='+')or (c=='-')or (c=='*')or (c=='/')or (c==';')or (c==':')or (c=='=')or (c=='^')or (c=='$')or (c=='&')or (c=='%') or (c=='|')or (c=='<')or (c=='>')or (c=='?') or (c=='!')or (c=='\')or (c=='~')or (c=='#'){
                if (c="="){
                    switch cpr {
                    case "+": ds_list_delete(plist,ds_list_size(plist)-1); ds_list_add(plist,"+=");cpr="+="; continue;
                    case "-": ds_list_delete(plist,ds_list_size(plist)-1); ds_list_add(plist,"-=");cpr="-="; continue;
                    case "/": ds_list_delete(plist,ds_list_size(plist)-1); ds_list_add(plist,"/=");cpr="/="; continue;
                    case "*": ds_list_delete(plist,ds_list_size(plist)-1); ds_list_add(plist,"*=");cpr="*="; continue;
                    case "=": ds_list_delete(plist,ds_list_size(plist)-1); ds_list_add(plist,"==");cpr="=="; continue;
                    case "<": ds_list_delete(plist,ds_list_size(plist)-1); ds_list_add(plist,"<=");cpr="<="; continue;
                    case ">": ds_list_delete(plist,ds_list_size(plist)-1); ds_list_add(plist,">=");cpr=">="; continue;
                    case "!": ds_list_delete(plist,ds_list_size(plist)-1); ds_list_add(plist,"!=");cpr="!="; continue;
                    case "|": ds_list_delete(plist,ds_list_size(plist)-1); ds_list_add(plist,"|=");cpr="|="; continue;
                    case "&": ds_list_delete(plist,ds_list_size(plist)-1); ds_list_add(plist,"&=");cpr="&="; continue;
                    case "^": ds_list_delete(plist,ds_list_size(plist)-1); ds_list_add(plist,"^=");cpr="^="; continue;
                    }
                }
                if (c="&") or (c="|") or (c="^") or (c=">") or (c="<") or (c="+") or (c="-") {
                    if c==cpr {
                        ds_list_delete(plist,ds_list_size(plist)-1); ds_list_add(plist,c+cpr);cpr=c+cpr; continue;
                    }
                }
                if ctoken!="" {
                    if (string_byte_at(ctoken,1)>=48) and (string_byte_at(ctoken,1)<=57)  {
                        ds_list_add(tplist,TP_DIGIT);
                    }
                    else {
                        ds_list_add(tplist,TP_VAR);
                    }
                    ds_list_add(plist,ctoken); 
                    ctoken=""; 
                }
                ds_list_add(plist,c);
                ds_list_add(tplist,TP_OPERATOR);
                if (c=="(" ) {
                    
                    if ds_list_size(tplist)>=2 {
                    //show_debug_message(tplist[| ds_list_size(tplist)-2]);
                    //show_debug_message(plist[| ds_list_size(plist)-2]);
                        if (tplist[| ds_list_size(tplist)-2]==TP_VAR) {
                            
                            //ds_list_delete(tplist,ds_list_size(tplist)-1); ds_list_add(plist,TP_FUNCTION);
                            tplist[| ds_list_size(tplist)-2]=TP_FUNCTION;
                            //show_debug_message(tplist[| ds_list_size(tplist)]);
                        }
                    }
                }
                if (c=="[" ) {
                    
                    if ds_list_size(tplist)>=2 {
                    //show_debug_message(tplist[| ds_list_size(tplist)-2]);
                    //show_debug_message(plist[| ds_list_size(plist)-2]);
                        if (tplist[| ds_list_size(tplist)-2]==TP_VAR) {
                            
                            //ds_list_delete(tplist,ds_list_size(tplist)-1); ds_list_add(plist,TP_FUNCTION);
                            tplist[| ds_list_size(tplist)-2]=TP_ARRAY;
                            //show_debug_message(tplist[| ds_list_size(tplist)]);
                        }
                    }
                }
            }
            else {
            
                ctoken+=c;
                
            }
        }
        cpr=c;
        //show_debug_message(a);
    }
    
    //for (i=0;ds_list_size(plist)-1;i++) {
        //s=" "//+plist[| i];
        //u=ord(string_char_at(s,1));
        //if ((u>=48) and (u<=57)){
        //digit
        //}
    //}
    var anlist=ds_list_create();
    
    for (i=0;i<ds_list_size(plist);i++){
        if (tplist[|i]==TP_OPERATOR){
            anlist[|i]=Qop_get_ind(plist[|i]);
            //anlist[|i]=plist[|i];
        }
        else if (tplist[|i]==TP_FUNCTION){
            anlist[|i]=Qfc_get_ind(plist[|i]);
            //anlist[|i]=plist[|i];
        }
        else {
            anlist[|i]=plist[|i];
        }
    }
    ds_list_destroy(plist);
    ds_list_add(list,anlist);
    ds_list_add(list,tplist);
    //ds_list_mark_as_list(list, 0);
    return list;
}
