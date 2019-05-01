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
        puts "      A   B   C   D   E   F   G   H"
    end

end

board = Board.new
board.setup
board.show_board
