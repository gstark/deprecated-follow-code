require_relative 'trace.rb'
$trace.enable

100.times do |index|
  @foo = index * 2
end

done = true
