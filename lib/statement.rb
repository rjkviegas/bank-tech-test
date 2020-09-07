class Statement
  attr_reader :transactions

  def initialize
    @transactions = []
  end

  def add(transaction)
    transactions << transaction
  end

  def show
    puts 'date || credit || debit || balance'
    transactions.reverse.each {|tr| puts stringify(tr) }
  end

  private

  def stringify(tr)
    if tr.credit?
      "#{tr.date} || #{tr.amount} || || #{tr.balance}"
    elsif tr.debit?
      "#{tr.date} || || #{tr.amount} || #{tr.balance}"
    end
  end
end
