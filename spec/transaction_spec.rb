# frozen_string_literal: true

require './lib/transaction'

describe Transaction do
  describe '#initialization' do
    let(:time_double) { double('time_double', strftime: '20/01/2020') }
    it 'credit transaction' do
      allow(Time).to receive(:now) { time_double }
      credit_transaction = Transaction.new('credit', 500)
      expect(credit_transaction).to have_attributes(
        type: 'credit',
        date: time_double.strftime,
        amount: 500,
      )
      expect(credit_transaction.credit?).to be true
      expect(credit_transaction.debit?).to be false
    end
    it 'debit transaction' do
      allow(Time).to receive(:now) { time_double }
      debit_transaction = Transaction.new('debit', 250)
      expect(debit_transaction).to have_attributes(
        type: 'debit',
        date: time_double.strftime,
        amount: 250,
      )
      expect(debit_transaction.credit?).to be false
      expect(debit_transaction.debit?).to be true
    end
  end
end
