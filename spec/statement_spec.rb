require "../lib/statement.rb"

describe Statement do
  describe '#initialize' do
    it '#transactions' do
      statement = Statement.new
      expect(statement).to have_attributes(:transactions => ['date || credit || debit || balance']) 
    end
  end
  describe '#add' do
    it 'string to transactions array' do
      statement = Statement.new
      expect(statement.transactions.length).to eq(1)
      statement.add('transaction')
      expect(statement.transactions.length).to eq(2)
      expect(statement.transactions[1]).to eq('transaction')
    end
  end
  describe '#print' do
    it 'all transactions' do
      statement = Statement.new
      statement.add('20/01/2020 || 500.00 || || 500.00')
      expect{ statement.print }.to output.to_stdout
      expect{ statement.print }.to output(puts statement.transactions).to_stdout
    end
  end
end
