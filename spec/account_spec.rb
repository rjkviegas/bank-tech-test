require '../lib/account.rb'

describe Account do
  describe Account.new(Statement) do
    it { is_expected.to have_attributes(:balance => 0) }
    it { is_expected.to have_attributes(:statement => an_instance_of(Statement)) }
  end
end
