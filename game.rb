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
        puts "Alright! Players are settled! It's #{@player1.name} versus #{@player2.name}! Let's see who goes first..."
        coin = rand(1..2)
        coin == 1 ? @currently_playing = @player1 : @currently_playing = @player2
        puts "***COIN FLIP***"
        puts "Looks like #{@currently_playing.name} is first to go!"
        puts
        puts "-------------------------------* HOW TO MOVE *-------------------------------"
        puts "You choose which piece to move, and where to move it by entering coordinates."
        puts "Enter them with a comma seperating them (Ex. A,2 or D,7)"
        puts "The letter picks a column, the number picks a row."
        puts "The coordinates will be displayed on the sides of the board."
        puts
        puts "Let's play!"
        game_status
    end
    
    def play_game
        setup
=begin
        game_over = false
        until game_over == true
            legal_move(player)
            check?(player)
            if check?(player) == true
                checkmate?(player)
                if checkmate?(player) == true
                    game_over = true
                end
            end
        show
=end
        5.times do
            legal_move(@currently_playing)
            switch_turns
        end
    end

    def legal_move(player)
        move_completed = false
        until move_completed == true
            piece = select_a_piece
            moves = generate_possible_moves(piece)
            location = select_a_location(moves)
            if location != 'cancel'
                move_completed = true
                board.move_piece(piece, piece.location ,location)
                if piece.class == Pawn
                    piece.has_moved
                end
            else
                puts "Canceling..."
            end
            board.erase_move_markers
            board.show
        end
        
=begin
            if valid_move_check?(selection) == true
                put_self_in_check?(selection)
                if put_self_in_check?(selection) == false
                    acceptable_move = true
                else
                    revert_move 
                end
            end
        end
        puts "Wow! A valid move"
=end    
    end

    def select_a_piece
        puts "#{@currently_playing.name}, enter the coordinates of the piece you'd like to move (Ex. A,1)"
        approved_selection = false
        until approved_selection == true
            coordinates = retrieve_appropriate_coordinates
            unless @board.location(coordinates[0], coordinates[1]).class == String
                if @board.location(coordinates[0], coordinates[1]).color == @currently_playing.color
                    approved_selection = true
                    selection = @board.location(coordinates[0], coordinates[1])
                else
                    puts "That's not your piece. Select again!"
                end
            else
                puts "There is no piece there. Select again!"
            end
        end
        selection
    end

    def generate_possible_moves(piece)
        move_list = []
        piece.movelist.each do |move|
            new_move = []
            new_x = (move[0] + piece.location[0])
            new_y = (move[1] + piece.location[1])
            unless new_x < 0 or new_x > 7 or new_y < 0 or new_y > 7
                new_move = [new_x, new_y]
                if board.location(new_x,new_y).class != String
                    if board.location(new_x,new_y).color != @currently_playing.color
                        move_list << new_move
                    end
                else
                    move_list << new_move
                end
            end
        end
        board.display_moves(move_list)
        puts "PIECE SELECTED: #{piece.class}"
        display_movelist(move_list)
        move_list
    end

    def select_a_location(move_list)
        puts "Okay, where would you like to move the piece to? Or you can enter 'cancel' to return to selecting a piece."
        approved = false
        until approved == true
            location = retrieve_appropriate_coordinates
            if move_list.any? { |move| move == location } == true or location == 'cancel'
                approved = true
            else
                puts "Not a valid location, enter one of the coordinates from the movelist."
                display_movelist(move_list)
            end
        end
        location
    end

    def letter_to_int(x)
        case x
            when 'a'
                x = 0
            when 'b'
                x = 1
            when 'c'
                x = 2
            when 'd'
                x = 3
            when 'e'
                x = 4
            when 'f'
                x = 5
            when 'g'
                x = 6
            when 'h'
                x = 7
        end
    end

    def int_to_letter(x)
        case x
            when 0 
                x = 'A'
            when 1
                x = 'B'
            when 2
                x = 'C'
            when 3
                x = 'D'
            when 4
                x = 'E'
            when 5
                x = 'F'
            when 6
                x = 'G'
            when 7
                x = 'H'
        end
    end

    def retrieve_appropriate_coordinates
        entry = gets.chomp.downcase
        approved = false
        until approved == true or entry == 'cancel'
            if entry == 'cancel'
                entry
            elsif entry =~ /[a-h],[1-8]/
                entry_split = entry.split(',')
                x = letter_to_int(entry_split[0])
                y = (entry_split[1].to_i - 1)
                entry = [x,y]
                approved = true
            else
                puts "Invalid Entry: enter a selection on the board in the format: A,1 (with the comma included, no spaces)"
                entry = gets.chomp.downcase
            end
        end
        entry
    end

    def game_over(winner)
        puts "Congratulations! #{winner.name} is the winner!"
        puts "-----------------GAME OVER-------------------"
        exit
    end

    def game_status
        puts "      #{@player1.name} = #{@player1.color}    #{@player2.name} = #{@player2.color}"
        board.show
    end

    def display_movelist(move_list)
        puts "--MOVE LIST--"
        move_list.each do |move|
            puts "   (#{int_to_letter(move[0])}, #{move[1] + 1})"
        end
        puts "-------------"
    end

    def switch_turns
        @currently_playing == @player1 ? @currently_playing = @player2 : @currently_playing = @player1
    end

end

game = Game.new
game.play_game