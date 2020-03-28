class Game
  def initialize
    @board = Board.new
    @turn = 'X'
    @round = 1
  end

  def start
    @board.show
    until (@board.victory? || @round > 9)
      input_player
      @board.show
      puts "Congratulations. #{@turn} won." if @board.victory?
      puts "It's a draw." if @round == 9
      change_player
    end
  end

  private

  def input_player
    puts "Insert the coordinates where you want to put an #{@turn}."
    loop do
      coords = gets.chomp.split('').map { |i| i.to_i - 1 }
      if valid?(coords)
        @board.insert(coords, @turn)
        break
      end
    end
  end

  def valid?(coords)
    if !@board.correct_format?(coords)
      puts "Invalid input. Use the format 'XY' (row-column)."
      return false
    elsif @board.occupied?(coords)
      puts "These coordinates are already occupied."
      return false
    else
      return true
    end
  end

  def change_player
    @turn == 'X' ? @turn = 'O' : @turn = 'X'
    @round += 1
  end
end


class Board
  def initialize
    @board = Array.new(3) { Array.new(3, ' ') }
  end

  def show
    puts
    puts "#{@board[0][0]} | #{@board[0][1]} | #{@board[0][2]}"
    puts '-- --- --'
    puts "#{@board[1][0]} | #{@board[1][1]} | #{@board[1][2]}"
    puts '-- --- --'
    puts "#{@board[2][0]} | #{@board[2][1]} | #{@board[2][2]}"
    puts
  end

  def correct_format?(coords)
    coords.size == 2 && 
      (0..2).include?(coords[0]) && (0..2).include?(coords[1])
  end

  def occupied?(coords)
    @board[coords[0]][coords[1]] != ' '
  end

  def insert(coords, turn)
    @board[coords[0]][coords[1]] = turn
  end

  def victory?
    horizontal_victory? || vertical_victory? || diagonal_victory?
  end

  private

  def horizontal_victory?(board=@board)
    board.any? { |i| i.all?('X') || i.all?('O') }
  end
  
  def vertical_victory?
    horizontal_victory?(@board.transpose)
  end

  def diagonal_victory?
    (@board[1][1] != ' ') &&
    ((@board[0][0] == @board[1][1] && @board[1][1] == @board[2][2]) ||
     (@board[2][0] == @board[1][1] && @board[1][1] == @board[0][2]))
  end
end


play = Game.new
play.start