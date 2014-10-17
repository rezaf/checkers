class Board
  
  attr_accessor :grid, :color, :pos
  
  def initialize(new_fill = true)
    self.grid = Array.new (8) { Array.new (8) }
    setup_board if new_fill
  end

  def [](pos)
    x, y = pos[0], pos[1]
    grid[x][y]
  end
  
  def []=(pos, piece)
    x, y = pos[0], pos[1]
    grid[x][y] = piece
  end
  
  def setup_board
    (0..3).each do |y|
      (0..2).each do |x|
        pos = (x.even? ? [x, y * 2] : [x, y * 2 + 1])
        self[pos] = Piece.new(pos, :white, self) 
      end
    end
    
    (0..3).each do |y|
      (5..7).each do |x|
        pos = (x.odd? ? [x, y * 2] : [x, y * 2 + 1])
        self[pos] = Piece.new(pos, :black, self) 
      end
    end
  end
  
  def render
    3.times { puts }
    puts "       0      1      2      3      4      5      6      7"
    grid.each_with_index do |row, i|
      2.times { puts }
      print "#{i}   "
      row.each_with_index do |square, j|
        unless square.nil?
          print (square.color == :white ? "   O   " : "   +   ")
        else
          print ((i + j).even? ? "_______" : "^^^^^^^")
        end
      end
    end 
    3.times { puts }
  end 
end