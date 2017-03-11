/// draw_text_box(x,y,text,col,alpha)
var w;
if argument2!=''{
draw_set_alpha(min(argument4,1)/2);
draw_set_colour(c_black);
draw_rectangle (argument0,argument1,argument0+string_width(argument2),argument1+20,false)
draw_text_colour(argument0,argument1,argument2,argument3,argument3,argument3,argument3,argument4 )
}
