require '../lib/account.rb'

describe Account do
  describe Account.new(Statement, Transaction) do
    it { is_expected.to have_attributes(:balance => 0) }
    it { is_expected.to have_attributes(:statement => an_instance_of(Statement)) }
    it { is_expected.to have_attributes(:transaction_class => Transaction) }
  end

  describe '#deposit' do
    let(:account) { Account.new(Statement, Transaction) }
    it 'adds amount to balance' do
      account.deposit('20/01/2020', 500)
      expect(account.balance).to eq(500)
    end
    it 'adds a credit transaction to the account statement' do 
      account.deposit('20/01/2020', 500)
      expect(account.statement.transactions).to eq(['date || credit || debit || balance', '20/01/2020 || 500.00 || || 500.00'])
    end
  end
end
