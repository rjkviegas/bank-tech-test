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
    balances = balances_generator.reverse
    print statement_header + "\n"
    transactions.reverse.each_with_index do |transaction, i|
      print transaction_row_formatter(transaction) +
        ' || ' + balances[-i] + '.00' + "\n"
    end
    @current_balance = nil  
  end

  def balance_calculator(transaction)
    @current_balance ||= 0
    if transaction.debit? 
      @current_balance -= transaction.amount
    elsif transaction.credit?
      @current_balance += transaction.amount
    end
  end

  private

  def statement_header
    'date || credit || debit || balance'
  end

  def transaction_row_formatter(transaction)
    row = transaction.date + ' || '
    if transaction.credit?
      row += transaction.amount.to_s + '.00' + ' ||'
    elsif transaction.debit?
      row += '|| ' + transaction.amount.to_s + '.00'
    end
  end

  def balances_generator
    transactions.map { |transaction| balance_calculator(transaction).to_s }
  end
end
