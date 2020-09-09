# frozen_string_literal: true

class Transaction
  attr_reader :type, :date, :amount

  def initialize(type, amount)
    @type = type
    @date = Time.now.strftime('%d/%m/%Y')
    @amount = amount
  end

  def credit?
    type == 'credit'
  end

  def debit?
    type == 'debit'
  end
end
