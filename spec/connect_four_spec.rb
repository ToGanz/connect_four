#spec/connecz_four_spec.rb
require './lib/connect_four'

RSpec.describe Board do
  subject(:board) { Board.new }

  describe "#initialize" do
    context "when game is started" do
      it { expect(board.grid).to eql(Array.new(6) { Array.new(7) { '_' } }) } 
    end
  end

  describe "#setup_board" do
    context "when game is started" do
      it { expect(board.setup_board).to eql(Array.new(6) { Array.new(7) { '_' } }) } 
    end
  end

  describe "#drop_piece" do
    context "when player chooses an empty col" do
      it "drops the piece in row 5" do
        board.drop_piece(0, 'X')
        expect(board.grid[5][0]).to eql('X')
      end
    end

    context "when player chooses a col with pieces already in" do
      it "drops the piece in row 4" do
        board.drop_piece(0, 'X')
        board.drop_piece(0, 'O')
        expect(board.grid[4][0]).to eql('O')
      end
    end

    context "when player chooses a full col" do
      it "returns false" do
        6.times { board.drop_piece(0, 'X') }
        expect(board.drop_piece(0, 'X')).to eql(false)
      end
    end

  end

end

RSpec.describe Game do
  subject(:game) { Game.new }

  describe "#initialize" do
    context "when game is started" do
      it { expect(game.board.grid).to eql(Array.new(6) { Array.new(7) { '_' } }) } 
    end
  end

  describe "#setup_board" do
    context "when game is started" do
      it { expect(game.board.setup_board).to eql(Array.new(6) { Array.new(7) { '_' } }) } 
    end
  end

  describe "#vertical_win?" do
    context "when four signs connect vertical" do
      it "returns true " do 
        (0..3).each { |row| game.board.grid[row][2] = "X" }
        expect(game.vertical_win?).to eql(true)
      end
    end

    context "when four signs are in a col but dont connect" do
      it "returns false " do 
        (0..2).each { |row| game.board.grid[row+1][2] = "X" }
        expect(game.vertical_win?).to eql(false)
      end
    end

  end

  describe "#horizontal_win?" do
    context "when four signs connect horizontal" do
      it "returns true " do 
        (0..3).each { |col| game.board.grid[2][col] = "X" }
        expect(game.horizontal_win?).to eql(true)
      end
    end

    context "when four signs are in a row but dont connect" do
      it "returns false " do 
        (0..2).each { |col| game.board.grid[2][col+1] = "X" }
        expect(game.horizontal_win?).to eql(false)
      end
    end
  end

  describe "#diagonal_win?" do
    context "when four signs connect diagonal" do
      it "returns true " do 
        (0..3).each { |idx| game.board.grid[idx][idx] = "O" }
        expect(game.diagonal_win?).to eql(true)
      end
    end
  end
    
  describe "#game_over?" do
    context "when four signs connect" do
      it "returns true " do 
        (0..3).each { |col| game.board.grid[2][col] = "X" }
        expect(game.game_over?).to eql(true)
      end
    end

    context "when four signs dont connect" do
      it "returns false" do 
        (0..3).each { |col| game.board.grid[2][col+col] = "X" }
        expect(game.game_over?).to eql(false)
      end
    end

  end

  describe "get_input" do
    context "when player makes a valid input (1)" do
      it "returns the column" do
        expect(game.get_input).to eql('1')
      end
    end

    context "when player makes an invalid input" do
      it "returns false" do
        expect(game.get_input).to eql(false)
      end
    end

  end

  # describe '#display' do
  #   it 'displays the board' do
  #     expect(game.display).to eql(true)
  #   end
  # end

end

RSpec.describe Player do
  subject(:player) { Player.new('X') }

  describe "#initialize" do
    context "when initialized" do
      it "returns sign " do 
        expect(player.sign).to eql('X')
      end
    end
  end

end
    