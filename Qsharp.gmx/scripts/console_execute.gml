with (console){
    console_write('Player: '+argument0,c_white)
    var command;


   
   for (i=16; i>0; i-=1)
   history[i] = history[i-1]
   history[0]=argument0

   command=string_parse(string_lower(argument0), " ", true);
   num=string_parse_number(string_lower(argument0), " ", true);
   if string_char_at(argument0,1)='/'{
      switch command[|0]{
             
             case '/qvm_test':
             Qtest("test.qs");
             break;
            
             case '/mem_on':
             memory = "";
             writing_to_memory = true;
             console_write("Writing in memory is ON",c_yellow)
             break;
             
             case '/mem_off':
             memory = "";
             writing_to_memory = false;
             console_write("Writing in memory is OFF",c_yellow)
             break;
             
             case '/show_mem':
             show_message_async(memory);
             break;
            
             case '/write': 
                console_write(string_delete(argument0,1,7),c_yellow)
             break; 
            
             case '/help': case '/?':
                console_write('This command is under development',c_orange)
             break; 
             
             case '/restart':
                game_restart()
             break;
             
             //case '/tomenu':
             //   room_goto(room_menu);
             //   exit;
             //break;
             
             //case '/save':
             //   game_save(ds_list_find_value(command,1)+".sv");
             //   exit;
             //break;
             
             //case '/load':
             //   game_load(ds_list_find_value(command,1)+".sv");
             //   exit;
             //break;
              
             
             /*case '/set':
                if (num==3) { 
                    switch ds_list_find_value(command,1){
                    case 'temp':
                        if (real(ds_list_find_value(command,2))>0.5) and string_letters(ds_list_find_value(command,2))='' {
                            gloabal.temp=real(ds_list_find_value(command,2))/10;
                            chat_add_line(ds_list_find_value(command,1)+' set to '+ds_list_find_value(command,2),c_orange )
    
                        }
                        else
                        {
                            chat_add_line('Error: Incorrect value',c_red)
                        }
                            
                    break;
                      
                    default:
                        chat_add_line('Error: Unknow object or global varible',c_red)
                    exit;
                    }
             
                }
                else {
                    chat_add_line('Error: wrong number of arguments',c_red);
                }
             break;*/
             
             default:
                     console_write('Error: Unknow command: '+command[|0],c_red);
             exit;
      }
   }
}
