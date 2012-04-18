class Numeric
    def in(target)
        if target.to_s=="dollor"
            self/1.send(target)
        else
            self.send(target)
        end
    end

    @@currencies = {'dollor' => 1.0, 'yen' => 0.013, 'euro' => 1.292, 'rupee' => 0.019}
    def method_missing(method_id)
        singular_currency = method_id.to_s.gsub( /s$/, '')
        if @@currencies.has_key?(singular_currency)
            self * @@currencies[singular_currency]
        else
            super
        end
    end
end


#puts 2.rupee.in(:dollor).between?(0.037,0.039)
#puts 2.rupee.in(:dollor).between?(0.037,0.039)
puts 2.rupee.in(:dollor)

class String
    def method_missing(method_id)
        if method_id.to_s=='palindrome?'
            sub=self.downcase.gsub(/[^a-z]/,'')
            sub.reverse==sub
        else
            super
        end
    end
end

#puts "Madam, I'm Adam!".palindrome?
#puts "not palindrome".palindrome?

module Enumerable
    def method_missing(method_id)
        if method_id.to_s=='palindrome?'
            array=self.collect {|x| x}
            array.reverse==array
        else
            super
        end
    end
end

#puts [1,2,3,2,1].palindrome?
#puts [1,2,3,4,2,1].palindrome?
#puts p={"hello"=>"word"}.palindrome?
#puts (1..9).palindrome?
