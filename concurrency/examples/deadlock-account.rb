require 'thread'
require_relative "deps"


TOTAL_THREADS = (ARGV[0] || 10).to_i



# TROUBLE

# john = V3::Account.new(2)
# jane = V3::Account.new(0)

# threads = []

# threads << Thread.new do
#   john.synchronize do
#     puts "John is busy"
#     sleep(1)
#     jane.synchronize do
#       puts "Jane is busy"
#       sleep(1)
#       if john.amount > 0
#         john.debit(1)
#         jane.credit(1)
#       end
#     end
#   end
# end

# threads << Thread.new do
#   jane.synchronize do
#     puts "Jane is busy"
#     sleep(1)
#     john.synchronize do
#       puts "John is busy"
#       sleep(1)
#       if jane.amount > 0
#         jane.debit(1)
#         john.credit(1)
#       end
#     end
#   end
# end


# threads.map(&:join)

# FIX

# john = V3::Account.new(2)
# jane = V3::Account.new(0)
# cv = ConditionVariable.new

# threads = []

# threads << Thread.new do
#   john.synchronize do
#     puts "John is busy"
#     sleep(1)
#     cv.wait(john.mutex)  # Temporarily sleeps the thread and releases the lock
#     puts "Jhon finished and release the lock"
#     jane.synchronize do
#       puts "Jane is trying to do the transaction"
#       sleep(1)
#       if john.amount > 0
#         john.debit(1)
#         jane.credit(1)
#       end
#     end
#   end
# end

# threads << Thread.new do
#   jane.synchronize do
#     puts "Jane is busy"
#     sleep(1)
#     john.synchronize do
#       puts "John is still busy, but almost done"
#       sleep(1)
#       if jane.amount > 0
#         jane.debit(1)
#         john.credit(1)
#       end
#     end
#     cv.signal
#   end
# end


# threads.map(&:join)



# item_accessories = {}
# item = {}
# item_acc_lock = Mutex.new
# item_lock = Mutex.new

# a = Thread.new {
#   item_acc_lock.synchronize {
#     sleep 1  # pretend to work on item_accessories
#     item_lock.synchronize {
#       # pretend to work on item
#       sleep 1
#       puts 'Worked on accessories, then on item'
#     }
#   }
# }

# b = Thread.new {
#   item_lock.synchronize {
#     sleep 1  # pretend to work on item
#     item_acc_lock.synchronize {
#       # pretend to work on item_accessories
#       sleep 1
#       puts 'Worked on item, then on accessories'
#     }
#   }
# }

# [a,b].map(&:join)