class Pawn
    attr_reader :symbol, :movelist, :color
    attr_accessor :location
    def initialize(color)
        
        if color == 'white'
            @symbol = "\u265f"
        elsif color == 'black'
            @symbol = "\u2659"
        end
        @color = color
        @moved = false
    end

    def set_location(x,y)
        @location = [x,y]
    end

    def movelist
        if @color == 'white'
            if @moved == false
                moves = [[0,1],[0,2]]
            else
                moves = [[0,1]]
            end
        else
            if @moved == false
                moves = [[0,-1],[0,-2]]
            else
                moves = [[0,-1]]
            end
        end
    end

    def has_moved
        @moved = true
    end
end

class Rook

    attr_reader :symbol, :movelist, :color
    attr_accessor :location
    def initialize(color)
        
        if color == 'white'
            @symbol = "\u265c"
        elsif color == 'black'
            @symbol = "\u2656"
        end
        @color = color
        
    end

    def set_location(x,y)
        @location = [x,y]
    end

    def movelist

    end

end

class Knight

    attr_reader :symbol, :movelist, :color
    attr_accessor :location
    def initialize(color)
        if color == 'white'
            @symbol = "\u265e"
        elsif color == 'black'
            @symbol = "\u2658"
        end
        @color = color
    end

    def set_location(x,y)
        @location = [x,y]
    end

    def movelist
        moves = [[1,2],[2,1],[2,-1],[1,-2],[-1,-2],[-2,-1],[-2,1],[-1,2]]
    end

end

class Bishop

    attr_reader :symbol, :movelist, :color
    attr_accessor :location
    def initialize(color)
        
        if color == 'white'
            @symbol = "\u265d"
        elsif color == 'black'
            @symbol = "\u2657"
        end
        @color = color
    end

    def set_location(x,y)
        @location = [x,y]
    end

    def movelist

    end

end

class Queen

    attr_reader :symbol, :movelist, :color
    attr_accessor :location
    def initialize(color)
        
        if color == 'white'
            @symbol = "\u265b"
        elsif color == 'black'
            @symbol = "\u2655"
        end
        @color = color
    end

    def set_location(x,y)
        @location = [x,y]
    end

    def movelist
        
    end

end

class King

    attr_reader :symbol, :movelist, :color
    attr_accessor :location
    def initialize(color)
        
        if color == 'white'
            @symbol = "\u265a"
        elsif color == 'black'
            @symbol = "\u2654"
        end
        @color = color
    end

    def set_location(x,y)
        @location = [x,y]
    end

    def movelist
        moves = [[1,0],[1,-1],[0,-1],[-1,-1],[-1,-0],[-1,1],[0,1],[1,1]]
    end

end

def axes_attack

    attackx = @location[0]
    attacky = @location[1]

    attackx -= 1
    if board.location(attackx, attacky).class == String
        move_list << board.location(attackx, attacky)
        
    else
    #    if board.location(attackx,attacky).color == 
    end

end

def diagonal_attack

    attackx = @location[0]
    attacky = @location[1]

end