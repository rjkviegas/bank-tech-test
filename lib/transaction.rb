class Transaction
  attr_reader :type, :date, :amount, :balance

  def initialize(type, date, amount, balance)
    @type = type
    @date = date
    @amount = amount
    @balance = balance
  end
end
