# Bank Tech Test

A Ruby program to be required in IRB (or a Ruby REPL equivalent) which allows the user to deposit/withdraw money from an account and print an up to date account statement.

## Requirements

- You should be able to interact with your code via a REPL like IRB or the JavaScript console. (You don't need to implement a command line interface that takes input from STDIN.)
- Deposits, withdrawal.
- Account statement (date, amount, balance) printing.
- Data can be kept in memory (it doesn't need to be stored to a database or anything).

## Acceptance Criteria

Given a client makes a deposit of 1000 on 10-01-2012<br>
And a deposit of 2000 on 13-01-2012<br>
And a withdrawal of 500 on 14-01-2012<br>
When she prints her bank statement<br>
Then she would see
```
date || credit || debit || balance
14/01/2012 || || 500.00 || 2500.00
13/01/2012 || 2000.00 || || 3000.00
10/01/2012 || 1000.00 || || 1000.00
```

## Set Up

Clone this repository. Then:
```
# RSpec for automated testing
> bundle install
```

## Testing

### Automated Testing
Move into root folder
```
rspec
```
### Manual Testing
To test Acceptance Criteria move into root folder
```
> irb
2.7.1 :001 > require './lib/account'
 # => true 
2.7.1 :002 > account = Account.new(Statement, Transaction)
2.7.1 :003 > account.deposit('10-01-2012', 1000)
 # => [#<Transaction:0x00007fb7589c8990 @type="credit", @date="10/01/2012", @amount=1000, @balance="1000">]
2.7.1 :004 > account.deposit('13-01-2012', 2000)
 # => [#<Transaction:0x00007fb7589c8990 @type="credit", @date="10/01/2012", @amount=1000, @balance="1000">, #<Transaction:0x00007fb758a3a090 @type="credit", @date="13/01/2012", @amount=2000, @balance="3000">]
2.7.1 :005 > account.withdrawal('14-01-2012', 500)
 # => [#<Transaction:0x00007fb7589c8990 @type="credit", @date="10/01/2012", @amount=1000, @balance="1000">, #<Transaction:0x00007fb758a3a090 @type="credit", @
2.7.1 :006 > account.statement.show
date || credit || debit || balance
14/01/2012 || || 500 || 2500
13/01/2012 || 2000 || || 3000
10/01/2012 || 1000 || || 1000
 # => [#<Transaction:0x00007fb75817ad88 @type="debit", @date="14/01/2012", @amount=500, @balance="2500">, #<Transaction:0x00007fb758a3a090 @type="credit", @date="13/01/2012", @amount=2000, @balance="3000">, #<Transaction:0x00007fb7589c8990 @type="credit", @date="10/01/2012", @amount=1000, @balance="1000">]
2.7.1 :007 > exit
```
