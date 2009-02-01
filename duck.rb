require 'irb/frame'

def next_shopper
  return DuckShopper.new
end

def say(arg)
  print "#{caller.name}: #{arg}"
  gets
  arg
end

def ask(person, question)
  print "#{caller.name}: #{question}"
  gets
  reply = person.send(question.split(' ').join('_'))
end

def caller
  binding = IRB::Frame.top(2)
  eval 'self', binding #caller
end

class DuckVendor
  def name
    'vendor'
  end

  def does_it_quack?
    say 'of course it quacks'
  end

  def a_what?
    say 'a duck'
  end

  def sell_duck
    ask next_shopper, 'would you like to buy a duck?'
  end
end

class DuckShopper
  @@count = 0
  def initialize
    @@count = @@count + 1
    @count = @@count
  end
  
  def name
    "shopper #{@count}"
  end

  def would_you_like_to_buy_a_duck?
    @provider = caller

    ask @provider, 'a what?'
    ask @provider, 'does it quack?'
    ask next_shopper, 'would you like to buy a duck?'
  end

  def does_it_quack?
    reply = ask @provider, 'does it quack?'
    say reply
  end

  def a_what?
    reply = ask @provider, 'a what?'
    say reply
  end
end

DuckVendor.new.sell_duck

