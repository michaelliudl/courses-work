class Numeric
  @@currencies = {'dollar' => 1.0, 'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019}
  def method_missing(method_id)
    singular_currency = method_id.to_s.gsub( /s$/, '')
    if @@currencies.has_key?(singular_currency)
      self * @@currencies[singular_currency]
    else
      super
    end
  end
  def in(method_id)
    singular_currency = method_id.to_s.gsub /s$/, ''
    if @@currencies.has_key? singular_currency
      self / @@currencies[singular_currency]
    else
      super
    end
  end
end

=begin
p 5.dollars.in(:euros)
p 10.euros.in(:rupees)
p 1.dollar.in(:rupees)
p 10.rupees.in(:euro)
=end

class String
    def palindrome?
        s = self.gsub(/[^a-zA-Z]*/, '').to_s.downcase
        s.reverse == s
    end
  # YOUR CODE HERE
end

module Enumerable
    def palindrome?
        array = self.collect { |x| x }
        array.reverse == array
    end
  # YOUR CODE HERE
end

#p 'foof'.palindrome?
#p [1,2,3,2,1].palindrome?
#p({:test=>1}.palindrome?)
