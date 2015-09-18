# require_relative 'trace.rb'
# $trace.enable

random = rand(100)
puts random #cheater mode
g_array = Array.new

def handle_guess(message, array)
  puts message
  g_remaining(array)
  gnum = gets.chomp.to_i
  array << gnum

  return gnum
end

def g_remaining(g_array)
##Personal Challenge Code below##
  left = 5 - g_array.length
  if left > 1
    #if g_array.length < 5
      puts "You have #{left} guesses remaing."
    #end

  elsif left == 1
     puts "Final guess! Choose wisely!"
  end

end

guess = handle_guess("Guess a number between 1-100", g_array)

while g_array.length < 5
  if guess > random
    guess = handle_guess("You guessed #{guess}, that's too high, try again.", g_array)

  elsif guess < random
    guess = handle_guess("You guessed #{guess}, that's too low, try again.", g_array)

  else guess == random
    break
  end
end

if guess == random
  puts "Congrats"
else
  puts "You were wrong 5 times, game over."
end



#
# g_array.each do |guess|
#   if guess == gnum
#     puts "A wise man once said, The definition of insanity is doing the same thing and expecting a different result, are you feeling ok?"
#   end
