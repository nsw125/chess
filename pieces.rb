class Pawn
    attr_reader :symbol, :color
    attr_accessor :location
    def initialize(color)
        
        if color == 'white'
            @symbol = "\u265f"
        elsif color == 'black'
            @symbol = "\u2659"
        end
        @color = color
        @moved = false
        update_movelist
    end

    def set_location(x,y)
        @location = [x,y]
    end

    def update_movelist
        if @color == 'white'
            if @moved == false
                @moves = [[0,1],[0,2]]
            else
                @moves = [[0,1]]
            end
        else
            if @moved == false
                @moves = [[0,-1],[0,-2]]
            else
                @moves = [[0,-1]]
            end
        end

        if @color == 'white'
            @attacks = [[-1,1],[1,1]]
        else
            @attacks = [[-1,-1],[1,-1]]
        end
    end

    def generate_possible_moves(board)
        legal_moves_list = []
        @moves.each do |move|
            new_move = []
            x = @location[0] + move[0]
            y = @location[1] + move[1]
            unless x > 7 or x < 0 or y > 7 or y < 0
                if board.location(x,y).class == String
                    new_move = [x,y]
                    legal_moves_list << new_move
                end
            end
        end
        @attacks.each do |attack|
            new_move = []
            x = @location[0] + attack[0]
            y = @location[1] + attack[1]
            unless x > 7 or x < 0 or y > 7 or y < 0
                if board.location(x,y).class != String
                    if board.location(x,y).color != @color
                        new_move = [x,y]
                        legal_moves_list << new_move
                    end
                end
            end
        end
        legal_moves_list
    end

    def has_moved
        @moved = true
    end
end

class Rook

    attr_reader :symbol, :color
    attr_accessor :location
    def initialize(color)
        
        if color == 'white'
            @symbol = "\u265c"
        elsif color == 'black'
            @symbol = "\u2656"
        end
        @color = color
        update_movelist
    end

    def set_location(x,y)
        @location = [x,y]
    end

    def update_movelist
        @moves = [[1,0],[0,-1],[-1,0],[0,1]]
    end

    def generate_possible_moves(board)
        move_list = []
        @moves.each do |move|
            path_end = false
            x = location[0]
            y = location[1]
            until path_end == true
                x += move[0]
                y += move[1]
                new_move = [x,y]
                if x < 0 or x > 7 or y < 0 or y > 7
                    path_end = true
                else
                    if board.location(x,y).class != String
                        if board.location(x,y).color != @color
                            move_list << new_move
                        else
                        end
                        path_end = true
                    else
                        move_list << new_move
                    end
                end
            end
        end
        move_list
    end
end

class Knight

    attr_reader :symbol, :color
    attr_accessor :location
    def initialize(color)
        if color == 'white'
            @symbol = "\u265e"
        elsif color == 'black'
            @symbol = "\u2658"
        end
        @color = color
        update_movelist
    end

    def set_location(x,y)
        @location = [x,y]
    end

    def update_movelist
        @moves = [[1,2],[2,1],[2,-1],[1,-2],[-1,-2],[-2,-1],[-2,1],[-1,2]]
    end

    def generate_possible_moves(board)
        legal_moves_list = []
        @moves.each do |move|
            new_move = []
            x = @location[0] + move[0]
            y = @location[1] + move[1]
            unless x > 7 or x < 0 or y > 7 or y < 0
                new_move = [x,y]
                if board.location(x,y).class == String
                    legal_moves_list << new_move
                else
                    if board.location(x,y).color != @color
                        legal_moves_list << new_move
                    end
                end
            end
        end
        legal_moves_list
    end

end

class Bishop

    attr_reader :symbol, :color
    attr_accessor :location
    def initialize(color)
        
        if color == 'white'
            @symbol = "\u265d"
        elsif color == 'black'
            @symbol = "\u2657"
        end
        @color = color
        update_movelist
    end

    def set_location(x,y)
        @location = [x,y]
    end

    def update_movelist
        @moves = [[1,1],[1,-1],[-1,-1],[-1,1]]
    end

    def generate_possible_moves(board)
        move_list = []
        @moves.each do |move|
            path_end = false
            x = location[0]
            y = location[1]
            until path_end == true
                x += move[0]
                y += move[1]
                new_move = [x,y]
                if x < 0 or x > 7 or y < 0 or y > 7
                    path_end = true
                else
                    if board.location(x,y).class != String
                        if board.location(x,y).color != @color
                            move_list << new_move
                        else
                        end
                        path_end = true
                    else
                        move_list << new_move
                    end
                end
            end
        end
        move_list
    end

end

class Queen

    attr_reader :symbol, :color
    attr_accessor :location
    def initialize(color)
        
        if color == 'white'
            @symbol = "\u265b"
        elsif color == 'black'
            @symbol = "\u2655"
        end
        @color = color
        update_movelist
    end

    def set_location(x,y)
        @location = [x,y]
    end

    def update_movelist
        @moves = [[1,0],[0,-1],[-1,0],[0,1],[1,1],[1,-1],[-1,-1],[-1,1]]
    end

    def generate_possible_moves(board)
        move_list = []
        @moves.each do |move|
            path_end = false
            x = location[0]
            y = location[1]
            until path_end == true
                x += move[0]
                #puts "X: #{x}"
                y += move[1]
                #puts "Y: #{y}"
                new_move = [x,y]
                if x < 0 or x > 7 or y < 0 or y > 7
                    path_end = true
                    #puts "End of the board!"
                else
                    if board.location(x,y).class != String
                        if board.location(x,y).color != @color
                            move_list << new_move
                            #puts "An enemy! Location (#{x},#{y})"
                        else
                            #puts "A friendly! Location (#{x},#{y})"
                        end
                        path_end = true
                    else
                        move_list << new_move
                        #puts "Move added: Location (#{x},#{y})"
                    end
                end
            end
        end
        move_list
    end
end

class King

    attr_reader :symbol, :color
    attr_accessor :location
    def initialize(color)
        
        if color == 'white'
            @symbol = "\u265a"
        elsif color == 'black'
            @symbol = "\u2654"
        end
        @color = color
        update_movelist
    end

    def set_location(x,y)
        @location = [x,y]
    end

    def update_movelist
        @moves = [[1,0],[1,-1],[0,-1],[-1,-1],[-1,-0],[-1,1],[0,1],[1,1]]
    end

    def generate_possible_moves(board)
        legal_moves_list = []
        @moves.each do |move|
            new_move = []
            x = @location[0] + move[0]
            y = @location[1] + move[1]
            unless x > 7 or x < 0 or y > 7 or y < 0
                new_move = [x,y]
                if board.location(x,y).class == String
                    legal_moves_list << new_move
                else
                    if board.location(x,y).color != @color
                        legal_moves_list << new_move
                    end
                end
            end
        end
        legal_moves_list
    end
end