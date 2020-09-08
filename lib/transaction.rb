# frozen_string_literal: true

class Transaction
  attr_reader :type, :date, :amount, :balance

  def initialize(type, date, amount, balance)
    @type = type
    @date = date.gsub('-', '/')
    @amount = amount
    @balance = balance
  end

  def credit?
    type == 'credit'
  end

  def debit?
    type == 'debit'
  end
end
