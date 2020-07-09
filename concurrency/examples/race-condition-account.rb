require 'thread'
require_relative "deps"

TOTAL_THREADS = (ARGV[0] || 10).to_i
TOTAL_TRANSACTIONS = 100_000
TOTAL = TOTAL_THREADS * TOTAL_TRANSACTIONS

puts "Crediting Account using #{TOTAL_THREADS} threads"



# TROUBLE

# john = V1::Account.new(0)

# threads = (0...TOTAL_THREADS).map do
#   Thread.new do
#     TOTAL_TRANSACTIONS.times do
#       john.credit(1)
#     end
#   end
# end

# threads.map(&:join)

# puts "Account john: #{john.amount}"

# FIX

# john = V1::Account.new(0)
# mutex = Mutex.new
# threads = (0...TOTAL_THREADS).map do
#   Thread.new do
#     TOTAL_TRANSACTIONS.times do
#       mutex.synchronize do
#         john.credit(1)
#       end
#     end
#   end
# end

# threads.map(&:join)

# puts "Account john: #{john.amount}"

# FIX 2

# john = V2::Account.new(0)
# threads = (0...TOTAL_THREADS).map do
#   Thread.new do
#     TOTAL_TRANSACTIONS.times do
#       john.credit(1)
#     end
#   end
# end

# threads.map(&:join)

# puts "Account john: #{john.amount}"

# TROUBLE

# puts "Transfering Funds from A to B using #{TOTAL_THREADS} threads"

# john = V1::Account.new(100_000)
# jane = V1::Account.new(0)

# threads = (0...TOTAL_THREADS).map {
#   Thread.new do
#     while john.amount > 0
#       john.debit(1)
#       jane.credit(1)
#     end
#   end
# }

# threads.each do |t| t.join end

# puts "Account john: #{john.amount}"
# puts "Account jane: #{jane.amount}"

# TROUBLE 2

# puts "Transfering Funds from A to B using #{TOTAL_THREADS} threads"

# john = V1::Account.new(100_000)
# jane = V1::Account.new(0)

# mutex = Mutex.new
# threads = (0...TOTAL_THREADS).map {
#   Thread.new do
#     while john.amount > 0
#       mutex.synchronize do
#         john.debit(1)
#         jane.credit(1)
#       end
#     end
#   end
# }

# threads.each do |t| t.join end

# puts "Account john: #{john.amount}"
# puts "Account jane: #{jane.amount}"


# FIX

# puts "Transfering Funds from A to B using #{TOTAL_THREADS} threads"

# john = V3::Account.new(100_000)
# jane = V3::Account.new(0)


# threads = (0...TOTAL_THREADS).map {
#   Thread.new do
#     while john.amount > 0
#       john.synchronize do
#         jane.synchronize do
#           if john.amount > 0
#             john.debit(1)
#             jane.credit(1)
#           end
#         end
#       end
#     end
#   end
# }

# threads.each do |t| t.join end

# puts "Account john: #{john.amount}"
# puts "Account jane: #{jane.amount}"