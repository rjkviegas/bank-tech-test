require_relative 'statement'

class Account
  attr_reader :balance, :statement

  def initialize(statement_class)
    @balance = 0
    @statement = statement_class.new
  end

  def deposit(amount)
    @balance += amount
  end
end
