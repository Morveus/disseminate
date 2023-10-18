function is_raspberry
   if test -f /proc/device-tree/model
       set model (cat /proc/device-tree/model)
       if string match -r 'Raspberry Pi' $model
           return 0
       else
           return 1
       end
   else
       return 1
   end
end
