# example4

def my_method(arg1: 1)
  p arg1
end

hash_parameter = { arg1: 100 }

# my_method(hash_parameter) => This call raises an ArgumentError

# double splat operator (**) is needed to pass keywords instead of a Hash.
my_method(**hash_parameter) # => 100

def other_method(arg1, **options)
  p arg1
end

# other_method(key: 40) => This call raises an ArgumentError

# write braces to make it an explicit hash
other_method({ key: 40 }) # => { :key => 40 }
