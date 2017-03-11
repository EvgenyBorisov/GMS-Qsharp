///Qop_get_ind(string);
var i;
for (i=0;i<OPERATORS_COUNT;i++){
    if argument0 == OPERATOR[# i, OPERATOR_STRING]{
        return i;
    }
}
Qerror("Operator "+string(argument0) +" is not supported now.");
return -1;
