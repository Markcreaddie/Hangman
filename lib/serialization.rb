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
                obj[var_symbol]=var.serialize2
            else
                obj[var_symbol]= var
            end
        end
        @@serializer.dump(obj)
    end
    def unserialize(string)
       obj=@@serializer.parse(string)
       obj.keys.each do |key|
        instance_variable_set(key,obj[key])
       end
    end

end


