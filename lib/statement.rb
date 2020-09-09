# frozen_string_literal: true

class Statement
  STATEMENT_HEADER = "date || credit || debit || balance\n"

  attr_reader :transactions

  def initialize
    @transactions = []
  end

  def add(transaction)
    transactions << transaction
  end

  def print_to_console
    balances_array = balances_generator
    print STATEMENT_HEADER
    transactions.reverse.each_with_index do |transaction, index|
      print row_formatter(transaction) + balances_array[index] + ".00\n"
    end
    @current_balance = nil
  end

  private

  def row_formatter(transaction)
    row = transaction.date + ' || '
    if transaction.credit?
      row += transaction.amount.to_s + '.00 ||'
    elsif transaction.debit?
      row += '|| ' + transaction.amount.to_s + '.00'
    end
    row + ' || '
  end

  def balance_calculator(transaction)
    @current_balance ||= 0
    if transaction.debit?
      @current_balance -= transaction.amount
    elsif transaction.credit?
      @current_balance += transaction.amount
    end
  end

  def balances_generator
    transactions.map { |transaction| balance_calculator(transaction).to_s }.reverse
  end
end
