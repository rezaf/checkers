require_relative './board.rb'
require_relative './piece.rb'

require 'byebug'

class Game

  #attr_accessor :move_sequence

  def initialize
    @board = Board.new
    @player1 = :white
    @player2 = :black
  end

  def play
    @board.render
    game_over = false
    player = @player1

    until game_over
      player = (player == @player1 ? @player2 : @player1)
  
      begin
        move_sequence = get_user_input(player)
        from_str = move_sequence[0]
        from = from_str.split(",").map! { |num| Integer(num) }
        @board[from].perform_moves(move_sequence) unless @board[from].nil?
        @board.render
      rescue RuntimeError => e
        puts e
        retry
      end
    end

    puts "Game Over!!!"
  end

  def get_user_input(player)
    puts "#{player.capitalize} player please enter your move(s) as an array:"
    gets.chomp.split(";")
  end
end

#debugger

if __FILE__ == $PROGRAM_NAME
  Game.new.play
end