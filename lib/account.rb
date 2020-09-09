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
    save_to_statement(@transaction_class.new('credit', amount, balance))
  end

  def withdrawal(amount)
    @balance -= amount
    save_to_statement(@transaction_class.new('debit', amount, balance))
  end

  private

  def save_to_statement(transaction)
    statement.add(transaction)
  end
end
