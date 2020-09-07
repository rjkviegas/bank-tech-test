require "../lib/statement.rb"

describe Statement do
  describe '#initialize' do
    it '#transactions' do
      statement = Statement.new()
      expect(statement).to have_attributes(:transactions => ['date || credit || debit || balance']) 
    end
  end
end
