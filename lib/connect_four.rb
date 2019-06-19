
class Game

  attr_accessor :board, :turn

  def initialize
    @board = Board.new
    @turn = 0
    @player1 = Player.new('X')
    @player2 = Player.new('O')
    @active_player = @player2
  end

  def get_input
    puts "Choose a Column (1-7)"
    input = gets.chomp
    return input if (1..7).include?(input.to_i) 
    false
  end

  def display
    puts " 1 2 3 4 5 6 7"
    @board.grid.each do |row|
      puts "|#{row[0]}|#{row[1]}|#{row[2]}|#{row[3]}|#{row[4]}|#{row[5]}|#{row[6]}|"
    end
  end

  def play
    while game_over? == false
      swap_players
      display
      input = false
      while input == false
        input = get_input
      end
      @board.drop_piece((input.to_i - 1), @active_player.sign)
      @turn += 1
      game_over?
    end
    display
    puts "Game Over!"
  end

  #private

  def game_over?
    return true if horizontal_win? || vertical_win? || diagonal_win? || @turn == 42
    false
  end

  def horizontal_win?
    @board.grid.each do |row| 
      if row.join(' ').match?(['X', 'X', 'X', 'X'].join(' '))
        return true
      elsif row.join(' ').match?(['O', 'O', 'O', 'O'].join(' '))
        return true
      end
    end
    false
  end

  def vertical_win?
    @board.grid.transpose.each do |col| 
      if col.join(' ').match?(['X', 'X', 'X', 'X'].join(' '))
        return true
      elsif col.join(' ').match?(['O', 'O', 'O', 'O'].join(' '))
        return true
      end
    end
    false
  end
 
  def diagonal_win?
    diagonals = []
    g = @board.grid
    #down up /
    diagonals << [g[3][0], g[2][1], g[1][2], g[0][3]]
    diagonals << [g[4][0], g[3][1], g[2][2], g[1][3], g[0][4]]
    diagonals << [g[5][0], g[4][1], g[3][2], g[2][3], g[1][4], g[0][5]]
    diagonals << [g[5][1], g[4][2], g[3][3], g[2][4], g[1][5], g[0][6]]
    diagonals << [g[5][2], g[4][3], g[3][4], g[2][5], g[1][6]]
    diagonals << [g[5][3], g[4][4], g[3][5], g[2][6]]
    # up down \
    diagonals << [g[0][3], g[1][4], g[2][5], g[3][6]]
    diagonals << [g[0][2], g[1][3], g[2][4], g[3][5], g[4][6]]
    diagonals << [g[0][1], g[1][2], g[2][3], g[3][4], g[4][5], g[5][6]]
    diagonals << [g[0][0], g[1][1], g[2][2], g[3][3], g[4][4], g[5][5]]
    diagonals << [g[1][0], g[2][1], g[3][2], g[4][3], g[5][4]]
    diagonals << [g[2][0], g[3][1], g[4][2], g[5][3]]

    diagonals.each do |row| 
      if row.join(' ').match?(['X', 'X', 'X', 'X'].join(' '))
        return true
      elsif row.join(' ').match?(['O', 'O', 'O', 'O'].join(' '))
        return true
      end
    end

    false
  end

  def swap_players
    if @active_player == @player1
      @active_player = @player2
    else
      @active_player = @player1
    end
	end

end

class Board
  attr_accessor :grid
  def initialize
    @grid = setup_board
  end

  def setup_board
    Array.new(6) { Array.new(7) { '_' } }
  end

  def drop_piece(column, piece)
    5.downto(0) do |row|
      if @grid[row][column] == '_'
        @grid[row][column] = piece
        return true
      end
    end
    puts "Column is full. Choose another column."
    false
  end

end

class Player
  attr_accessor :sign

  def initialize(sign)
    @sign = sign
  end


end

game = Game.new
game.play