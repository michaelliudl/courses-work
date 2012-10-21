class Dessert
  attr_accessor :name, :calories
  def initialize(name, calories)
      @name, @calories = name, calories
    # YOUR CODE HERE
  end
  
  def healthy?
      @calories < 200
    # YOUR CODE HERE
  end
  
  def delicious?
      true
    # YOUR CODE HERE
  end
end

class JellyBean < Dessert
  attr_accessor :flavor
  def initialize(name, calories, flavor)
      super(name, calories)
      @flavor = flavor
    # YOUR CODE HERE
  end
  
  def delicious?
      @flavor != 'black licorice'
    # YOUR CODE HERE
  end
end
