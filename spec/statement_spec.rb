require "../lib/statement.rb"

describe Statement do
  describe '#initialize' do
    it '#transactions' do
      statement = Statement.new
      expect(statement).to have_attributes(:transactions => []) 
    end
  end
  describe '#add' do
    it 'string to transactions array' do
      statement = Statement.new
      transaction_double = double('transaction')
      expect(statement.transactions.length).to eq(0)
      statement.add(transaction_double)
      expect(statement.transactions.length).to eq(1)
      expect(statement.transactions[0]).to eq(transaction_double)
    end
  end
  describe '#print' do
    it 'all transactions in reverse chronological order' do
      credit_trans_double = double(
        'transaction', 
        :type => 'credit', 
        :date => '20/01/2020', 
        :amount => 500, 
        :balance => 500,
      )
      debit_trans_double = double(
        'transaction', 
        :type => 'debit', 
        :date => '21/01/2020', 
        :amount => 200, 
        :balance => 300,
        :credit? => true
      )
      statement = Statement.new
      statement.add(credit_trans_double)
      allow(credit_trans_double).to receive(:credit?) { true }
      expect{ statement.show }.to output(
        "date || credit || debit || balance\n" +
        "20/01/2020 || 500 || || 500\n"
      ).to_stdout
      statement.add(debit_trans_double)
      allow(debit_trans_double).to receive(:credit?) { false }
      allow(debit_trans_double).to receive(:debit?) { true }
      expect{ statement.show }.to output(
        "date || credit || debit || balance\n" +
        "21/01/2020 || || 200 || 300\n" +
        "20/01/2020 || 500 || || 500\n"
      ).to_stdout
    end
  end
end
