class Dessert
    def initialize(name,calories)
        @name=name
        @calories=calories
    end

    attr_accessor :name
    attr_accessor :calories
    
    def healthy?
        @calories<200
    end

    def delicious?
        true
    end
end

class JellyBean < Dessert
    def initialize(name,calories,flavor)
        @name=name
        @calories=calories
        @flavor=flavor
    end
    attr_accessor :name
    attr_accessor :calories
    attr_accessor :flavor

    def delicious?
        not @flavor=="black licorice"
    end
end

#test_dessert=JelleyBean.new("test name",180,"black licorice")
#puts test_dessert.delicious?
#puts test_dessert.health?


