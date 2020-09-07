require '../lib/transaction'

describe Transaction do
  describe '#initialization' do
    it 'credit transaction' do
    credit_transaction = Transaction.new('credit', '20/01/2020', 500, 1000)
    expect(credit_transaction).to have_attributes(
      :type=> 'credit', 
      :date => '20/01/2020', 
      :amount => 500, 
      :balance => 1000
    ) 
    end
    it 'debit transaction' do
      debit_transaction = Transaction.new('debit', '21/01/2020', 250, 750)
      expect(debit_transaction).to have_attributes(
        :type=> 'debit', 
        :date => '21/01/2020', 
        :amount => 250, 
        :balance => 750
      ) 
      end
  end
end
