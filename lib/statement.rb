class Statement
  attr_reader :transactions

  def initialize
    @transactions = ['date || credit || debit || balance']
  end

  def add(transaction)
    transactions << transaction
  end

  def print
    puts @transactions
  end
end
