require 'irb/frame'

def next_shopper
  return DuckShopper.new
end

def say(arg)
  print "#{caller.name}: #{arg}"
  gets
  arg
end

def caller
  binding = IRB::Frame.top(2)
  eval 'self', binding #caller
end

class DuckVendor
  def name
    'vendor'
  end

  def does_it_quack
    say 'of course it quacks'
  end

  def a_what
    say 'a duck'
  end

  def sell_duck
    say 'would you like to buy a duck?'
    next_shopper.would_you_like_to_buy_a_duck
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

  def would_you_like_to_buy_a_duck
    @prev_asker = caller

    say 'a what?'
    @prev_asker.a_what

    say 'does it quack?'
    @prev_asker.does_it_quack

    say 'would you like to buy a duck?'
    next_shopper.would_you_like_to_buy_a_duck
  end

  def does_it_quack
    say 'does it quack?'
    say @prev_asker.does_it_quack
  end

  def a_what
    say 'a what?'
    say @prev_asker.a_what
  end
end

DuckVendor.new.sell_duck

