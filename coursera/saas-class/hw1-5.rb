class Class
    def attr_accessor_with_history(attr_name)
        attr_name=attr_name.to_s
        attr_reader attr_name
        attr_reader attr_name+"_history"
        class_eval %Q{
            def #{attr_name}=(val)
                @#{attr_name}=val
                @#{attr_name}_history=[nil] if @#{attr_name}_history.nil?
                @#{attr_name}_history.push(val)
            end
        }
    end
end

class Foo
    attr_accessor_with_history :bar
end

f=Foo.new
f.bar=1
f.bar=2
puts f.bar_history
