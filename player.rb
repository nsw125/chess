class Player
        attr_accessor :name
        attr_reader :number, :color
        
    def initialize(number)
        puts "Player #{number}: Enter your name!"
        name = gets.chomp
        @name = name
        puts "Welcome, #{@name}!"
        if number == 1
            @color = 'white'
        else
            @color = 'black'
        end
        puts
    end

end
