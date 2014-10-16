require_relative 'piece.rb'
require_relative 'board.rb'

class Game
 
  def initialize(player1, player2)
    @board = Board.new
    @player1 = player1
    @player2 = player2
  end
  
  def play
    
  end
  
end