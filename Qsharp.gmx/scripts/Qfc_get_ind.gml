///Qfc_get_ind(string);
var i;
for (i=0;i<FUNCTIONS_COUNT;i++){
    if argument0 == FUNCTION[# i, FUNCTION_STRING]{
        return i;
    }
}

Qerror("Function "+string(argument0) +" is not declareated.");

return -1;
