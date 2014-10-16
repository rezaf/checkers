require_relative 'board.rb'

class InvalidMoveError < RuntimeError
end

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
  
  def perform_slide(from, to, board) 
    if slide_legal?(from, to)
      board[from], board[to] = nil, board[from]
      @pos = to
      maybe_promote
    else
      return false
    end
    true
  end
  
  def slide_legal?(from, to, board)
    return false unless board[to].nil?
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
  
  def perform_jump(from, to, board)
    jumps = legal_jumps(from, to)
    
    unless jumps.empty?
      board[from], board[to] = nil, board[from]
      @pos = to
      
      remove = []
      remove[0] = to[0] - from[0]
      remove[1] = to[1] - from[1]
      
      remove[0] += (remove[0] > 0 ? -1 : 1)
      remove[1] += (remove[1] > 0 ? -1 : 1)
      
      board[to] = nil
      return true
    end
    false
  end
  
  def legal_jumps(from, to, board)
    possible_moves = []
    move_diffs.each do |move|
      possible_moves << move if board[move].color != @color
    end
    possible_moves
  end
  
  def perform_moves!(move_sequence, board)
    move_sequence[0...-1].each_index do |index|
      from, to = move_sequence[index], move[index + 1]
      if perform_jump(from, to)
        nil
      elsif perform_slide(from, to)
        break
      else
        raise InvalidMoveError
      end
    end
  end
  
  def valid_move_seq?(move_sequence)
    dup_board = deep_dup
      
    !!perform_moves!(move_sequence, dup_board)# ? true : false
  end
  
  def deep_dup
    dup_board = Board.new(false)
    (0..7).each do |x|
      (0..7).each do |y|
        position = [x, y]
        next if self[position].nil?
        color = self[position].color
        dup_board[position] = 
          self[position].class.new(position, color, dup_board)
      end
    end
    
    dup_board
  end
  
  def perform_moves(move_sequence)
    if valid_move_seq?(move_sequence)
      perform_moves!(move_sequence, self)
    else
      raise InvalidMoveError
    end
  end
  
  def move_diffs(from)
    move_diff(from).select do |move|
      move[0].between(0, 7) && move[1].between(0, 7)
    end
  end
  
  def move_diff(from)
    diffs = [] 
    if @king
      diffs = KING_DIFFS.map { |move| [move[0] + from[0], move[1] + from[1] }
    elsif @color = :white
      diffs = W_PAWN_DIFFS.map { |move| [move[0] + from[0], move[1] + from[1] }
    else
      diffs = B_PAWN_DIFFS.map { |move| [move[0] + from[0], move[1] + from[1] }
    end 
    diffs
  end
  
  def maybe_promote
    if @color == :white && pos[0] == 7
      @king = true
    elsif @color == :black && pos[0] == 0
      @king = true
    end
  end 
end