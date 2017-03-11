with (console){
///chat_add_line(text,col)
for (i=CONSOLE_LINES; i>0; i-=1){
chat[i] = chat[i-1] 
chat_alpha[i] = chat_alpha[i-1] 
chat_color[i] = chat_color[i-1]
chat_l[i] = chat_l[i-1]
}//сдвигаем строки вверх
chat[0] = argument0//добавляем новую строку
chat_alpha[0]=16
chat_color[0]=argument1
chat_l[0]=string_width(argument0)
if (writing_to_memory) {memory+=argument0+"#"}
}
