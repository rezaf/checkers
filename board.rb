class Board
  
  attr_accessor :grid
  
  def initialize(new_fill = true)
    grid = Array.new (8) { Array.new (8) }
    setup_board if new_fill
  end
  
  def [](position)
    x, y = pos[0], pos[1]
    grid[x][y]
  end
  
  def []=(position, piece)
    x, y = pos[0], pos[1]
    grid[x][y] = piece
  end
  
  def setup_board
    (0..2).each do |y|
      (0..3).each do |x|    
        x = x + 1 if y.even?
        pos = [x * 2, y]
        self[pos] = Piece.new(pos, :white, grid) 
      end
    end
    
    (5..7).each do |y|
      (1..4).each do |x|    
        x = x + 1 if y.odd?
        pos = [x * 2, y]
        self[pos] = Piece.new(pos, :black, grid) 
      end
    end
    
  end
  
end