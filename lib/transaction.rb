class Transaction
  attr_reader :string

  def initialize(date, type, amount, balance)
    if type === 'credit'
      @string = "#{date} || #{amount}.00 || || #{balance}.00"
    elsif type === 'debit'
      @string = "#{date} || || #{amount}.00 || #{balance}.00"
    end
  end
end
