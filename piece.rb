require_relative 'board.rb'

class Piece
  
  attr_reader :color :pos :board
  
  W_PAWN_DIFFS = [[1, 1], [-1, 1]]

  B_PAWN_DIFFS = [[1, -1], [-1, -1]]

  KING_DIFFS = W_PAWN_DIFFS + B_PAWN_DIFFS
  
  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @board = board
    @king = false
  end
  
  def perform_slide(from, to) 
    if slide_legal?(from, to)
      @board[from], @board[to] = nil, @board[from]
      @pos = to
      maybe_promote
    else
      return false
    end
    true
  end
  
  def slide_legal?(from, to)
    return false unless @board[to].nil?
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
    legal_jumps = jump_legal?(from, to)
    
    unless legal_jumps.empty?
      @board[from], @board[to] = nil, @board[from]
      remove = []
      remove[0] = to[0] - from[0]
      remove[1] = to[1] - from[1]
      
      remove[0] += (remove[0] > 0 ? -1 : 1)
      remove[1] += (remove[1] > 0 ? -1 : 1)
      
      @board[to] = nil
    end
    
  end
  
  #change method name
  def jump_legal?(from, to)
    possible_moves = []
    move_diffs.each do |move|
      possible_moves << move if board[move].color != @color
    end
    possible_moves
  end
  
  #refactor with helper method
  def move_diffs(from)
    diffs = []
    
    if @king
      diffs = KING_DIFFS.map { |move| [move[0] + from[0], move[1] + from[1] }
    elsif @color = :white
      diffs = W_PAWN_DIFFS.map { |move| [move[0] + from[0], move[1] + from[1] }
    else
      diffs = B_PAWN_DIFFS.map { |move| [move[0] + from[0], move[1] + from[1] }
    end
    
    diffs.select { |diff| diff[0].between(0, 7) && diff[1].between(0, 7) }
  end
  
  def maybe_promote
    if @color == :white && pos[0] == 7
      @king = true
    elsif 
      @color == :black && pos[0] == 0
      @king = true
    end
  end
  
end