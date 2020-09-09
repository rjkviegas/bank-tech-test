# frozen_string_literal: true

require './lib/account.rb'

describe 'Feature Tests' do
  describe Account.new(Statement, Transaction) do
    it { is_expected.to have_attributes(balance: 0) }
    it { is_expected.to have_attributes(statement: an_instance_of(Statement)) }
    it { is_expected.to have_attributes(transaction_class: Transaction) }
  end

  describe '#deposit' do
    let(:time_double) { double('time_double', strftime: '20/01/2020') }
    let(:account) { Account.new(Statement, Transaction) }
    it 'adds amount to balance' do
      expect { account.deposit(500) }.to change { account.balance }.by 500
    end
    it 'adds a credit transaction to the account statement' do
      allow(Time).to receive(:now) { time_double }
      expect { account.deposit(500) }.to change { account.statement.transactions.length }.by 1
      expect(account.statement.transactions).to include(a_kind_of(Transaction))
      expect(account.statement.transactions[0].type).to eq('credit')
      expect(account.statement.transactions[0].date).to eq(time_double.strftime)
      expect(account.statement.transactions[0].amount).to eq(500)
    end
  end

  describe '#withdrawal' do
    let(:time_double) { double('time_double', strftime: '20/01/2020') }
    let(:account) { Account.new(Statement, Transaction) }
    it 'subtracts amount from balance' do
      expect { account.withdrawal(250) }.to change { account.balance }.by(-250)
    end
    it 'adds a debit transaction to the account statement' do
      allow(Time).to receive(:now) { time_double }
      account.withdrawal(300)
      expect { account.deposit(300) }.to change { account.statement.transactions.length }.by 1
      expect(account.statement.transactions).to include(a_kind_of(Transaction))
      expect(account.statement.transactions[0].type).to eq('debit')
      expect(account.statement.transactions[0].date).to eq(time_double.strftime)
      expect(account.statement.transactions[0].amount).to eq(300)
    end
  end
end
