class Board

        require './pieces'

    def initialize
        @board =   [['-','-','-','-','-','-','-','-'],
                    ['-','-','-','-','-','-','-','-'],
                    ['-','-','-','-','-','-','-','-'],
                    ['-','-','-','-','-','-','-','-'],
                    ['-','-','-','-','-','-','-','-'],
                    ['-','-','-','-','-','-','-','-'],
                    ['-','-','-','-','-','-','-','-'],
                    ['-','-','-','-','-','-','-','-']]

    end

    def setup

        row = 6
        @board.each do |space|
            pawn = Pawn.new(1)
            space[row] = pawn
        end

        row = 1
        @board.each do |space|
            pawn = Pawn.new(2)
            space[row] = pawn
        end

        rook1 = Rook.new(1)
        rook2 = Rook.new(2)
        @board[0][7] = rook1
        @board[7][7] = rook1
        @board[0][0] = rook2
        @board[7][0] = rook2

        kn1 = Knight.new(1)
        kn2 = Knight.new(2)
        @board[1][7] = kn1
        @board[6][7] = kn1
        @board[1][0] = kn2
        @board[6][0] = kn2

        bish1 = Bishop.new(1)
        bish2 = Bishop.new(2)
        @board[2][7] = bish1
        @board[5][7] = bish1
        @board[2][0] = bish2
        @board[5][0] = bish2

        queen1 = Queen.new(1)
        queen2 = Queen.new(2)
        @board[3][7] = queen1
        @board[3][0] = queen2

        king1 = King.new(1)
        king2 = King.new(2)
        @board[4][7] = king1
        @board[4][0] = king2

    end

    def show_board
        row = 7
        until row < 0
            puts "    ---------------------------------"
            print "#{row + 1}   "
            @board.each do |column|
                if column[row].class == String
                    print "| #{column[row]} " 
                else
                    print "| #{column[row].symbol} "
                end
            end
            print '|'
            puts 
            row -= 1
        end
        puts "    ---------------------------------"
        puts "      1   2   3   4   5   6   7   8"
    end

    def move_piece(x,y)
        selection = @board[x - 1][y - 1]
        if selection.class != String
            puts "You've selected: #{selection.symbol}"
            possible_moves = selection.movelist
            puts "Possible Moves!"
            puts "-----------"
            possible_moves.each do |move|
                move[0] += x
                move[1] += y
                if @board[move[0]][move[1]].class == String
                    @board[move[0]][move[1]] = 'X'
                end
                puts "(#{move.join(', ')})"
            end
            puts "-----------"

        else
            puts "You've selected: #{selection}, select again."
        end
        
    end

end

board = Board.new
board.setup
board.show_board
board.move_piece(2,2)
board.show_board
