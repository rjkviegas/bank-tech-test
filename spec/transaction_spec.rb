require '../lib/transaction'

describe Transaction do
  describe '#initialization' do
    it 'creates credit transaction row for statement' do
    credit_transaction = Transaction.new('20/01/2020', 'credit', 500, 1000)
    expect(credit_transaction.string).to eq('20/01/2020 || 500.00 || || 1000.00')
    end
    it 'creates debit transaction row for statement' do
      debit_transaction = Transaction.new('21/01/2020', 'debit', 250, 750)
      expect(debit_transaction.string).to eq('21/01/2020 || || 250.00 || 750.00')
      end
  end
end
