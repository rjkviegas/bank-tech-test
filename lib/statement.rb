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
    transaction_in_reverse_chronological_order = transactions.reverse
    balances_in_reverse_chronological_order = generate_balances_array.reverse
    print STATEMENT_HEADER
    transaction_in_reverse_chronological_order.each_with_index do |transaction, index|
      print format_row(transaction) + balances_in_reverse_chronological_order[index] + ".00\n"
    end
    @current_balance = nil
  end

  private

  def format_row(transaction)
    row = transaction.date + ' || '
    if transaction.credit?
      row += transaction.amount.to_s + '.00 ||'
    elsif transaction.debit?
      row += '|| ' + transaction.amount.to_s + '.00'
    end
    row + ' || '
  end

  def calculate_current_balance(transaction)
    @current_balance ||= 0
    if transaction.debit?
      @current_balance -= transaction.amount
    elsif transaction.credit?
      @current_balance += transaction.amount
    end
  end

  def generate_balances_array
    transactions.map { |transaction| calculate_current_balance(transaction).to_s }
  end
end
