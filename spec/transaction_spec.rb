# frozen_string_literal: true

require './lib/transaction'

describe Transaction do
  describe '#initialization' do
    let(:timeDouble) { double('timeDouble', strftime: '20/01/2020') }
    it 'credit transaction' do
      allow(Time).to receive(:now) {timeDouble}
      credit_transaction = Transaction.new('credit', 500, 1000)
      expect(credit_transaction).to have_attributes(
        type: 'credit',
        date: timeDouble.strftime,
        amount: 500,
        balance: 1000
      )
      expect(credit_transaction.credit?).to be true
      expect(credit_transaction.debit?).to be false
    end
    it 'debit transaction' do
      allow(Time).to receive(:now) {timeDouble}
      debit_transaction = Transaction.new('debit', 250, 750)
      expect(debit_transaction).to have_attributes(
        type: 'debit',
        date: timeDouble.strftime,
        amount: 250,
        balance: 750
      )
      expect(debit_transaction.credit?).to be false
      expect(debit_transaction.debit?).to be true
    end
  end
end
