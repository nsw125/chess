class Player
        attr_accessor :name
        attr_reader :number
        
    def initialize(number)
        puts "Player #{number}: Enter your name!"
        name = gets.chomp
        @name = name
        puts "Welcome, #{@name}!"
        @number = number
    end

end
