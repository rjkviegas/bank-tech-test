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
    credit_transaction = @transaction_class.new('credit', date, amount, "#{balance}")
    save(credit_transaction)
  end

  def withdrawal(date, amount)
    @balance -= amount
    debit_transaction = @transaction_class.new('debit', date, amount, "#{balance}")
    save(debit_transaction)
  end

  private

  def save(transaction)
    statement.add(transaction)
  end
end
