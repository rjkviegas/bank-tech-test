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

  def stringify(transaction)
    if transaction.credit?
      "#{transaction.date.gsub('-', '/')} || #{transaction.amount} || || #{transaction.balance}"
    elsif transaction.debit?
      "#{transaction.date.gsub('-', '/')} || || #{transaction.amount} || #{transaction.balance}"
    end
  end
end
