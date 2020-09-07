require_relative 'statement'
require_relative 'transaction'

class Account
  attr_reader :balance, :statement, :transaction_class

  def initialize(statement_class, transaction_class)
    @balance = 0
    @statement = statement_class.new
    @transaction_class = transaction_class
  end

  def deposit(date, amount)
    @balance += amount
    credit_transaction = @transaction_class.new(date, 'credit', amount, "#{balance}")
    statement.add(credit_transaction.string)
  end

  def withdrawal(date, amount)
    @balance -= amount
    debit_transaction = @transaction_class.new(date, 'debit', amount, "#{balance}")
    @statement.add(debit_transaction.string)
  end
end
