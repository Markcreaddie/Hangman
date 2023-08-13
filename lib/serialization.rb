require "json"

module BasicSerializable
    @@serializer=JSON

 #   def serialize()
 #       obj ={}
  #      instance_variables.each do |var|
  #          obj[var]= instance_variable_get(var)
   #     end
   #     @@serializer.dump(obj)
  #  end

    def serialize()
        obj={}
        instance_variables.each do |var_symbol|
            var=instance_variable_get(var_symbol)
            unless var.instance_variables==[]
                obj[var_symbol]=var.serialize
            else
                obj[var_symbol]= var
            end
        end
        @@serializer.dump(obj)
    end
    def unserialize(my_string)
       obj=@@serializer.parse(my_string)
       obj.each do |key,value|
        if value[0]=="{"
            instance_variable_get(key).unserialize(value)
        else
            instance_variable_set(key,value)
        end
       end
    end

end


