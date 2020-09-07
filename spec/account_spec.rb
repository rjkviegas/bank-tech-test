require '../lib/account.rb'

describe Account do
  describe Account.new(Statement) do
    it { is_expected.to have_attributes(:balance => 0) }
    it { is_expected.to have_attributes(:statement => an_instance_of(Statement)) }
  end

  describe '#deposit' do
    it 'adds amount to balance' do
      account = Account.new(Statement)
      account.deposit(500)
      expect(account.balance).to eq(500)
    end
  end
end
