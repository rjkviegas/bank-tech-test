# frozen_string_literal: true

require_relative 'statement'
require_relative 'transaction'

class Account
  attr_reader :balance, :statement, :transaction_class

  def initialize(statement_class, transaction_class)
    @balance = 0
    @statement = statement_class.new
    @transaction_class = transaction_class
  end

  def deposit(amount)
    @balance += amount
    save(@transaction_class.new('credit', amount, balance.to_s))
  end

  def withdrawal(amount)
    @balance -= amount
    save(@transaction_class.new('debit', amount, balance.to_s))
  end

  private

  def save(transaction)
    statement.add(transaction)
  end
end
