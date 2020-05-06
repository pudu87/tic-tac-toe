require './tic_tac_toe.rb'

describe Board do
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