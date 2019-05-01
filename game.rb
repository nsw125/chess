class Game
    require './board'
    require './pieces'
    require './player'

    attr_accessor :board
    def initialize
        @board = Board.new
        @board.setup
    end

    def setup
        puts "Welcome to CHESS! The classic game of big brains."
        puts
        puts "Who's playing?"
        puts "The first player will play white pieces."
        puts "The second player will play the black pieces."
        @player1 = Player.new(1)
        @player2 = Player.new(2)
        puts "Alright! Players are settled! Let's see who goes first..."
        coin = rand(1..2)
        coin == 1 ? @currently_playing = @player1 : @currently_playing = @player2
        puts "***COIN FLIP***"
        puts "Looks like #{@currently_playing.name} is first to go!"
        puts
        puts "You choose which piece to move, and where to move it by entering two numbers."
        puts "Enter them with a comma seperating them (Ex. 1,2 or 5,7)"
        puts "The first number picks a column, the second picks a row."
        puts "Let's play!"
        @board.show_board
    end
    
    def play
        #until checkmate == true
            puts "#{@currently_playing.name}, its your turn!"
            player_turn(@currently_playing)
            puts
            puts "      #{@player1.name} = White   #{@player2.name} = Black"
            @board.show_board
        #end
        #declare winner!
    end

    def player_turn(currently_playing)
        
    end

    def game_over
    
    end
end

game = Game.new
game.setup
game.play