module MyTomcat

 def MyTomcat.retriveall(rows, template)
   out_obj = Hash.new()
     for i in 0..rows.length-1
       #p rows[i]
       instance = rows[i].at(9).downcase+"-"+rows[i].at(1).downcase+"-"+MyS3.convert(rows[i].at(2))+"-"+rows[i].at(11)
       #p instance
       offset = rows[i].at(10)
       #p offset

       default_obj = MyYAML.read(template)
       new_obj = MyYAML.tomcat(default_obj, instance, offset)

       # Print nicely YAML content
       #MyYAML.nice(out_obj)
       #print "\n\n"

       out_obj.merge!(new_obj)
     end
   return out_obj
 end

 def MyTomcat.modify(template, file, instance, offset)
   default_obj = MyYAML.read(template)
   obj = MyYAML.read(file)

   if obj.has_key?(instance)
     value = '8' + offset
     if obj[instance]['http_port'] != value
       new_obj = MyYAML.tomcat(default_obj, instance, offset)
       obj.merge!(new_obj)
     end
   else
     new_obj = MyYAML.tomcat(default_obj, instance, offset)
     obj.merge!(new_obj)
   end
   return obj
 end

end
