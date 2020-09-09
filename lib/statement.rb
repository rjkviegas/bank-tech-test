# frozen_string_literal: true

class Statement
  attr_reader :transactions

  def initialize
    @transactions = []
  end

  def add(transaction)
    transactions << transaction
  end

  def print_to_console
    print statement_header + "\n"
    transactions.reverse.each { |transaction| print (transaction_row_formatter(transaction) + "\n") }
  end

  private

  def statement_header
    'date || credit || debit || balance'
  end

  def transaction_row_formatter(transaction)
    row = transaction.date +  ' || '
    if transaction.credit?
      row += transaction.amount.to_s + '.00' + ' ||'
    elsif transaction.debit?
      row += '|| ' + transaction.amount.to_s + '.00'
    end
    row += ' || ' + transaction.balance.to_s + '.00'
  end
end
