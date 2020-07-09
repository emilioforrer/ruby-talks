require 'thread'
require_relative "deps"


## TROUBLE

# order = Order.new(100.00, 'pending')


# 5.times.map do
#   Thread.new do
#       if order.pending?
#         order.complete!
#       end
#   end
# end.each(&:join)


# FIX

# order = Order.new(100.00, 'pending')
# mutex = Mutex.new

# 1000.times.map do
#   Thread.new do
#     mutex.synchronize do
#       if order.pending?
#         order.complete!
#       end
#     end
#   end
# end.each(&:join)

# FIX 2

# order = Order.new(100.00, 'pending')
# queue = Queue.new
# queue << order

# 5.times.map do
#   Thread.new do
#       order = queue.pop(true)
#       if order.pending?
#         order.complete!
#       end
#       rescue ThreadError
#       # raised by Queue#pop in the threads
#       # that don't pop the sheep
#   end
# end.each(&:join)


# FIX 3

# order = Order.new(100.00, 'pending')
# queue = Queue.new
# queue << order

# 5.times.map do
#   Thread.new do
#     until queue.empty?
#       order = queue.pop()
#       if order.pending?
#         order.complete!
#       end
#     end
#   end
# end.each(&:join)