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

        row = 1
        @board.each do |space|
            space[row] = Pawn.new('white')
        end

        row = 6
        @board.each do |space|
            space[row] = Pawn.new('black')
        end

        @board[0][0] = Rook.new('white')
        @board[7][0] = Rook.new('white')
        @board[0][7] = Rook.new('black')
        @board[7][7] = Rook.new('black')

        @board[1][0] = kn1 = Knight.new('white')
        @board[6][0] = kn1 = Knight.new('white')
        @board[1][7] = kn2 = Knight.new('black')
        @board[6][7] = kn2 = Knight.new('black')

        @board[2][0] = Bishop.new('white')
        @board[5][0] = Bishop.new('white')
        @board[2][7] = Bishop.new('black')
        @board[5][7] = Bishop.new('black')

        @board[3][0] = Queen.new('white')
        @board[3][7] = Queen.new('black')

        @board[4][0] = King.new('white')
        @board[4][7] = King.new('black')

        @board.each_with_index do |column, x|
            column.each_with_index do |space, y|
                if space.class != String
                    space.set_location(x,y)
                end
            end
        end

    end

    def set_value(value, location)
        @board[location[0]][location[1]] = value
    end
    


    def show
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

    def location(x,y)
        @board[x][y]
    end

    def display_moves(moves)
        moves.each do |move|
            if @board[move[0]][move[1]].class == String
                @board[move[0]][move[1]] = 'X'
            end
        end
        show
    end
    
    def erase_move_markers
        @board.each_with_index do |column, x|
            column.each_with_index do |space, y|
                if space == 'X'
                   @board[x][y] = '-'
                end
            end
        end
    end

    def move_piece(piece, start, target, castling = false)
        if castling == false
            @board[target[0]][target[1]] = piece
            @board[start[0]][start[1]] = '-'
            piece.set_location(target[0],target[1])
        else
            puts "Castling?!"
        end
        puts "#{piece.class}: #{piece.location}"
    end

    def collect_all_my_pieces(currently_playing, checkmate = false)
        players_pieces = []
        @board.each_with_index do |column,x|
            column.each_with_index do |row, y|
                if @board[x][y].class != String
                    if @board[x][y].color == currently_playing.color
                        piece = @board[x][y]
                        unless piece.class == King and checkmate == true
                            players_pieces << piece
                        end
                    end
                end
            end
        end
        players_pieces
    end

    def search_for_king(defender)
        enemy_king = nil
        @board.each_with_index do |column, x|
            column.each_with_index do |row, y|
                if @board[x][y].class == King
                    if @board[x][y].color == defender.color
                        enemy_king = @board[x][y]
                        #puts "Found him! #{enemy_king}"
                    end
                end
            end
        end
        enemy_king
    end

    def test_move?(piece, start, target)
        location = @board[target[0]][target[1]]
        @board[target[0]][target[1]] = piece
        @board[start[0]][start[1]] = location

        @board
    end

    def revert_move(piece, start, target)
        location = @board[start[0]][start[1]]
        @board[start[0]][start[1]] = piece
        @board[target[0]][target[1]] = location

        @board

    end
end

#board = Board.new
#board.setup
#board.show
