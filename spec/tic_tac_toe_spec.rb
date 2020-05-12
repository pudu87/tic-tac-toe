require './tic_tac_toe.rb'

describe Board do
  describe "#occupied?" do
    it "returns true if position is occupied" do
      subject.board[0,0] = "OCCUPIED"
      expect(subject.occupied?([0,0])).to eq(true)
    end
    it "returns false if position is free" do
      expect(subject.occupied?([1,1])).to eq(false)
    end
  end

  describe "#victory?" do
    it "accepts a horizontal victory" do
      subject.board[1][0], subject.board[1][1], subject.board[1][2] = 'X', 'X', 'X'
      expect(subject).to be_victory
    end
    it "accepts a vertical victory" do
      subject.board[0][1], subject.board[1][1], subject.board[2][1] = 'O', 'O', 'O'
      expect(subject).to be_victory
    end
    it "accepts a diagonal victory" do
      subject.board[0][0], subject.board[1][1], subject.board[2][2] = 'X', 'X', 'X'
      expect(subject).to be_victory
    end
    it "does not accept any full row as a victory" do
      subject.board[1][0], subject.board[1][1], subject.board[1][2] = 'X', 'O', 'X'
      expect(subject).not_to be_victory
    end
  end
end

describe Game do
  describe "start" do
    it "stops automatically after 9 or more rounds" do
      subject.round = 10
      expect_any_instance_of(Board).to receive(:show)
      subject.start
      expect(subject).not_to receive(:input_player)
    end
    it "stops when there is a winner" do
      expect_any_instance_of(Board).to receive(:show)
      expect_any_instance_of(Board).to receive(:victory?).and_return(true)
      subject.start
      expect(subject).not_to receive(:input_player)
    end
  end

  # PRIVATE

  # describe "input_player" do
  #   it "asks for player input and processes it" do
  #     expect(STDOUT).to receive(:puts).with(instance_of(String))
  #     allow(subject).to receive(:gets).and_return("11\n")
  #     subject.input_player
  #     expect(subject.coords).to eq([0,0])
  #   end
  # end

  # describe "#valid?" do
  #   it "checks if input is valid" do
  #     expect(subject).to receive(:correct_format?).with([1,1]).and_return(true)
  #     expect_any_instance_of(Board).to receive(:occupied?).with([1,1]).and_return(false)
  #     expect(subject.valid?([1,1])).to eq(true)
  #   end
  # end
end