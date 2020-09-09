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
    it 'transaction to transactions array' do
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
        date: time_double.strftime,
        amount: 500,
        credit?: true,
        debit?: false
      )
      debit_double = double(
        'transaction',
        date: time_double.strftime,
        amount: 200,
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
      it 'returns positive transaction amount when it receives a credit transaction' do
        credit_double = double('transaction', amount: 500, debit?: false, credit?: true)
        statement = Statement.new
        expect(statement.balance_calculator(credit_double)).to eq(credit_double.amount)
      end

      it 'returns negative transaction amount when it receives a debit transaction' do
        debit_double = double('transaction', amount: 500, debit?: true, credit?: false)
        statement = Statement.new
        expect(statement.balance_calculator(debit_double)).to eq(-debit_double.amount)
      end

    describe 'more than one transaction' do

      let(:debit_double) { double('transaction', amount: 500, debit?: true, credit?: false) }
      let(:credit_double) { double('transaction', amount: 200, debit?: false, credit?: true) }
      let(:statement) { Statement.new }

      it 'returns sum of amounts when it receives two debit transactions' do
        expect(statement.balance_calculator(debit_double)).to eq(-debit_double.amount)
        expect(statement.balance_calculator(debit_double)).to eq(-2*debit_double.amount)
      end

      it 'returns sum of amounts when it receives a two credit transactions' do
        expect(statement.balance_calculator(credit_double)).to eq(credit_double.amount)
        expect(statement.balance_calculator(credit_double)).to eq(2*credit_double.amount)
      end

      it 'returns difference in amounts when it receives a credit transaction and then a debit transaction' do
        expect(statement.balance_calculator(credit_double)).to eq(credit_double.amount)
        expect(statement.balance_calculator(debit_double)).to eq(credit_double.amount - debit_double.amount)
      end
    end
  end
end
