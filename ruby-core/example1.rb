# Proc to Block Example, using "&"

def find_roots(x0, f, fprime)
  puts "Find roots\n"
  yield(x0, f, fprime)
end

newton_proc = proc do |x0, f, fprime|
  tolerance = 1e-7      # needed accuracy
  epsilon = 1e-14       # minimun number to be divided100
  max_iterations = 100  # maximun iterations
  result = 0

  solution_found = false
  puts "Starting Newton-Raphson\n"

  (1..max_iterations).each do |i|
    y = f.call(x0)
    yprime = fprime.call(x0)
    break if yprime.abs < epsilon # stop if denominator too small

    x1 = x0 - (y.to_f / yprime)

    # iteration results
    puts '--------------------------------------'
    puts "iteration: #{i} \nx: #{x1} \nacuracy: #{x1 - (y.to_f / yprime)} \nf(x): #{y}\n"

    if (x1 - x0).abs <= tolerance   # stop if result within tolerance
      solution_found = true
      result = x1
      break
    end

    x0 = x1
  end

  if solution_found
    puts "\nSolution x: #{result}"
  else
    puts '\nDid not converge.'
  end
end

f = ->(x) { x * x - 2 }
fprime = ->(x) { 2 * x }

find_roots(1, f, fprime, &newton_proc)
