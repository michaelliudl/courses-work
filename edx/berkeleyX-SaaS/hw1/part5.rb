class Class
  def attr_accessor_with_history(attr_name)
    attr_name = attr_name.to_s   # make sure it's a string
    attr_reader attr_name        # create the attribute's getter
    attr_reader attr_name+"_history" # create bar_history getter
    class_eval %Q{
           def #{attr_name}=(value)
             @#{attr_name} = value
             @#{attr_name}_history = [nil] if !(@#{attr_name}_history)
             @#{attr_name}_history << value
           end}
  end
end

class Foo
    attr_accessor_with_history :bar
    attr_accessor_with_history :baz
end
foo = Foo.new
foo.bar = 3
foo.bar = 'bbbbb'
foo.bar = Object.new

foo.baz = 'bazzzz'
foo.baz = 100
p foo.bar_history
p foo.baz_history
