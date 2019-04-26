class Pawn
    attr_reader :symbol, :movelist
    def initialize(player)
        
        if player == 1
            @symbol = "\u2659"
            @color = 'white'
        elsif player == 2
            @symbol = "\u265f"
            @color = 'black'
        end
        @movelist = [[0,1],[0,2]]
    end

    def has_moved
        @movelist = [0,1]
    end
end

class Rook

    attr_reader :symbol, :movelist
    def initialize(player)
        
        if player == 1
            @symbol = "\u2656"
            @color = 'white'
        elsif player == 2
            @symbol = "\u265c"
            @color = 'black'
        end
        
    end

end

class Knight

    attr_reader :symbol, :movelist
    def initialize(player)
        
        if player == 1
            @symbol = "\u2658"
            @color = 'white'
        elsif player == 2
            @symbol = "\u265e"
            @color = 'black'
        end
        @movelist = [[1,2],[2,1],[2,-1],[1,-2],[-1,-2],[-2,-1],[-2,1],[-1,2]]
    end

end

class Bishop

    attr_reader :symbol, :movelist
    def initialize(player)
        
        if player == 1
            @symbol = "\u2657"
            @color = 'white'
        elsif player == 2
            @symbol = "\u265d"
            @color = 'black'
        end
    end

end

class Queen

    attr_reader :symbol, :movelist
    def initialize(player)
        
        if player == 1
            @symbol = "\u2655"
            @color = 'white'
        elsif player == 2
            @symbol = "\u265b"
            @color = 'black'
        end
    end

end

class King

    attr_reader :symbol, :movelist
    def initialize(player)
        
        if player == 1
            @symbol = "\u265a"
            @color = 'white'
        elsif player == 2
            @symbol = "\u265a"
            @color = 'black'
        end
    end

end