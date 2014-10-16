require_relative 'board.rb'

class Piece
  
  attr_reader :color
  
  W_PAWN_DIFFS = [[1, 1], [-1, 1]]

  B_PAWN_DIFFS = [[1, -1], [-1, -1]]

  King_DIFFS = W_PAWN_DIFFS + B_PAWN_DIFFS
  
  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @board = board
    @king = false
  end
  
  def perform_slide(from, to) 
    if @board[to].nil? && slide_legal?
      @board[from], @board[to] = nil, @board[from]
      @pos = to
      maybe_promote
    else
      return false
    end
    true
  end
  
  def slide_legal?(from, to)
    proposed_move = [to[0] - from[0], to[1]] - from[1]]
  
    if @king
      legal_move = KING_DIFFS.include?(proposed_move)
    elsif @color == :white
      legal_move = W_PAWN_DIFFS.include?(proposed_move) 
    else
      legal_move = B_PAWN_DIFFS.include?(proposed_move)
    end
    
    legal_move
  end
  
  def perform_jump(from, to)
    
    
  end
  
  def jump_legal?(from, to)
    if color != @color in valid_moves, true
  end
  
  def move_diffs(pos)
    diffs = []
    
    if @king
      diffs = KING_DIFFS.map { |move| [move[0] + pos[0], move[1] + pos [1] } 
      
  end
  
  def maybe_promote
    if @color == :white && @pos[0] == 7
      @king = true
    elsif 
      @color == :black && @pos[0] == 0
      @king = true
    end
  end
  
end