class Statement
  attr_reader :transactions
  
  def initialize
    @transactions = ['date || credit || debit || balance']
  end
end
