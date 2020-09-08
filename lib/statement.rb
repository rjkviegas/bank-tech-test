# frozen_string_literal: true

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
    transactions.reverse.each { |tr| puts stringify(tr) }
  end

  private

  def stringify(trans)
    if trans.credit?
      "#{trans.date} || #{trans.amount} || || #{trans.balance}"
    elsif trans.debit?
      "#{trans.date} || || #{trans.amount} || #{trans.balance}"
    end
  end
end
