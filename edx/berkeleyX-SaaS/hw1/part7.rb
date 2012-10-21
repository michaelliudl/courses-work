class CartesianProduct
  include Enumerable
  # YOUR CODE HERE
  def initialize(a, b)
      @first, @second = a, b
  end
  def each
      @first.each do |f|
          @second.each do |s|
              yield [f, s]
          end
      end
  end
end
=begin
c = CartesianProduct.new([:a, :b], [4, 5])
c.each { |elt| puts elt.inspect }

c = CartesianProduct.new([:a, :b], [])
c.each { |elt| puts elt.inspect }
=end
