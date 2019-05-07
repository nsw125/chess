class Game
    require './board'
    require './pieces'
    require './player'
    require 'yaml'
    
    attr_accessor :board
    def initialize
        @board = Board.new
        @board.setup
    end

    def setup
        puts "Welcome to CHESS! The classic game of big brains."
        puts
        puts "Are we starting a new game? Or loading a previous one? (n/l)"
        selection = gets.chomp.downcase
        until selection == 'n' or selection == 'l'
            puts "That is not an appropriate selection: Either (n) for new, or (l) for load."
            selection = gets.chomp.downcase
        end
        if selection == 'l'
            load_game
        else
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
        end
    end
    
    def play_game
        setup
        #until checkmate? == true
        10.times do
            legal_move(@currently_playing)
            if check? == true
                player_pieces = board.collect_all_my_pieces(@currently_playing)
                reachable_tiles = generate_reachable_tiles(player_pieces)
                if checkmate?(reachable_tiles) == true
                    game_over(@currently_playing)
                end
                @currently_playing == @player1 ? defender = @player2 : defender = @player1
                puts "---------#{defender.name}, YOU ARE IN CHECK!---------"
            end
            switch_turns
        end
        #end
    end

    def legal_move(player)
        move_completed = false
        until move_completed == true
            game_status
            piece = select_a_piece
            puts "Piece: #{piece.class}"
            puts "Location: #{piece.location}"
            moves = piece.generate_possible_moves(board)
            board.display_moves(moves)
            display_movelist(moves)
            location = select_a_location(moves)
            if location != 'cancel'
                move_completed = true
                board.move_piece(piece, piece.location ,location)
                if piece.class == Pawn
                    piece.has_moved
                end
                piece.update_movelist
            else
                puts "Canceling..."
            end
            board.erase_move_markers
        end
    end

    def select_a_piece
        puts "#{@currently_playing.name}, enter the coordinates of the piece you'd like to move (Ex. A,1)"
        puts "You can also save this game with 'save', and load another game with 'load'."
        approved_selection = false
        until approved_selection == true
            coordinates = retrieve_appropriate_coordinates
            if coordinates == 'cancel'
                puts "You can't cancel your turn!"
            else
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
        end
        selection
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
            if entry == 'exit'
                exit
            elsif entry == 'cancel'
                entry
            elsif entry == 'save'
                save_game
                entry = nil
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
        puts
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
            print "   (#{int_to_letter(move[0])}, #{move[1] + 1})"
            if board.location(move[0],move[1]).class != String
                print " (Attack: #{board.location(move[0],move[1]).class})"
            end
            puts
        end
        puts "-------------"
    end

    def switch_turns
        @currently_playing == @player1 ? @currently_playing = @player2 : @currently_playing = @player1
    end

    def check?(defender = nil)
        if defender == nil
            @currently_playing == @player1 ? defender = @player2 : defender = @player1
        end
        enemy_king = board.search_for_king(defender)

        players_pieces = board.collect_all_my_pieces(@currently_playing)
        threats = []
        check = false
        reachable_tiles = generate_reachable_tiles(players_pieces)
        if reachable_tiles.any? { |move| move == enemy_king.location} == true
            check = true
        end
        check
    end

    def generate_reachable_tiles(pieces)
        reachable_tiles = []
        pieces.each do |piece|
            moves = piece.generate_possible_moves(board)
            unless moves == []
                moves.each do |move|
                    reachable_tiles << move
                end
            end
        end
        reachable_tiles
    end

    def checkmate?(reachable_tiles)
        @currently_playing == @player1 ? defender = @player2 : defender = @player1
        enemy_king = board.search_for_king(defender)

        enemy_king_moves = enemy_king.generate_possible_moves(board)
        check = true
        if enemy_king_moves.all? { |escape_move| reachable_tiles.any? { |attack| attack == escape_move } } == true
            puts "The king can't go anywhere, checking for blocks/counters"
            pieces = board.collect_all_my_pieces(defender, true)
            move_list = []
            pieces.each do |piece|
                moves = piece.generate_possible_moves(board)
                moves.each do |move|
                    board.test_move?(piece, piece.location, move)
                    if check? == false
                        check = false
                    end
                    board.revert_move(piece, piece.location, move)
                end
            end
            if check == false
                puts "There is a move that can be made to prevent checkmate!"
            end
        end
        puts check
        check
    end

    def test_move(move_list)
        @currently_playing == @player1 ? defender == @player2 : defender == @player1
        move_list.each do |move|
            
        end
    end
    
    def save_game
        exists = Dir.exists? "saves"
        if exists == false
            Dir.mkdir "saves"
        end
        Dir.chdir "saves"
        puts "Enter a name for the save file."
        save_id = gets.chomp.downcase.to_s
        until save_id != 'exit'
            puts "You cannot save a file with that name."
            save_id = gets.chomp.downcase.to_s
        end
        game_state = YAML::dump({

            :board => @board,
            :player1 => @player1,
            :player2 => @player2,
            :currently_playing => @currently_playing
    
        })
        if File.exists? "#{save_id}"
            puts "A file already exists with that name, are you sure? (y/n)"
            confirm = gets.chomp.downcase
            until confirm == 'y' or confirm == 'n'
                puts "That is not an option, enter (y)es or (n)o."
                confirm = gets.chomp.downcase
            end
            if confirm == 'y'
                puts "File overwritten!"
                save = File.new("#{save_id}", "w+")
                save.puts game_state
                save.close
            end
        else
            puts "New file saved!"
            save = File.new("#{save_id}", "w+")
            save.puts game_state
            save.close
        end
        puts "Now that we're done with that, let's continue playing, or 'exit' to exit the game."
        Dir.chdir ".."
    end

    def load_game
        Dir.chdir "saves"
        saves = Dir.glob('*')
        puts "Current saves: #{saves}"
        puts "Which game would you like to load?"
        selection = gets.chomp.downcase
        game = File.exists? "#{selection}"
        if game == true
            puts Dir.getwd
            game = YAML.load(File.open("#{selection}", 'r'))
            @board = game[:board]
            @player1 = game[:player1]
            @player2 = game[:player2]
            @currently_playing = game[:currently_playing]
            puts @board
            puts @player1.name
            puts @player2.name
            game_status
        else
            puts "There is no game with that name on file."
            puts "Either enter a new one, or exit to exit."
        end
        Dir.chdir '..'
    end
end

game = Game.new
game.play_game

=begin

    Left to do: Check only checks if the player can move his king to a safe position.
                    -Needs to check if a piece can block the attack, or if the attacking piece can be captured.
                Save function added
                Computer player

=end