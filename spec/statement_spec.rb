# frozen_string_literal: true

require './lib/statement.rb'

describe Statement do
  describe '#initialize' do
    it '#transactions' do
      statement = Statement.new
      expect(statement).to have_attributes(transactions: [])
    end
  end
  describe '#add' do
    it 'string to transactions array' do
      statement = Statement.new
      transaction_double = double('transaction')
      expect(statement.transactions.length).to eq(0)
      statement.add(transaction_double)
      expect(statement.transactions.length).to eq(1)
      expect(statement.transactions.first).to eq(transaction_double)
    end
  end
  describe '#print_to_console' do
    let(:time_double) { double('time_double', strftime: '20/01/2020') }
    it 'transactions in reverse-chronological order' do
      allow(Time).to receive(:now) { time_double }
      credit_double = double(
        'transaction',
        type: 'credit',
        date: time_double.strftime,
        amount: 500,
        balance: 500,
        credit?: true,
        debit?: false
      )
      debit_double = double(
        'transaction',
        type: 'debit',
        date: time_double.strftime,
        amount: 200,
        balance: 300,
        credit?: false,
        debit?: true
      )
      statement = Statement.new
      allow(statement).to receive(:transactions) { [credit_double] }
      expect { statement.print_to_console }.to output(
        "date || credit || debit || balance\n"\
        "20/01/2020 || 500.00 || || 500.00\n"
      ).to_stdout
      allow(statement).to receive(:transactions) { [credit_double, debit_double] }
      expect { statement.print_to_console }.to output(
        "date || credit || debit || balance\n"\
        "20/01/2020 || || 200.00 || 300.00\n"\
        "20/01/2020 || 500.00 || || 500.00\n"
      ).to_stdout
    end
  end
  describe '#balance_calculator' do
    it 'returns 0 when no transaction have been added' do
      statement = Statement.new
      expect(statement.balance_calculator).to eq(0)
    end
  end
end
