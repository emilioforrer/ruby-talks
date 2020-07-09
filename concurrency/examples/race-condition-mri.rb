
# @bank_account = 0
# 100.times.map do 
#  Thread.new do
#   100_000.times do
#    value = @bank_account
#    value = value + 1 unless false
#    @bank_account = value
#   end
#  end
# end.each(&:join)
# puts @bank_account


# @bank_account = 0
# def read_account
#   @bank_account
# end
# def add_value(value)
#   @bank_account = value
# end
# 100.times.map do 
#  Thread.new do
#   100_000.times do
#    value = read_account
#    value = value + 1
#    add_value(value)
#   end
#  end
# end.each(&:join)
# puts @bank_account