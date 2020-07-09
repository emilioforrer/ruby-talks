started_at = Time.now

require_relative("scrapper")

data = Concurrent::Array.new



sequential_link = -> (link) {
  data << Scrapper.get_page(link)
}

thread_link = -> (link) {
  Thread.new {
    data << Scrapper.get_page(link)
  }
}

fiber_link = -> (link) {
  Fiber.new {
    page = Scrapper.get_page(link)
    data << page
    Fiber.yield page
  }
}

Scrapper.get_links.each_slice(25) do |links|
  threads = []
  # fibers = []
  links.each do |link|
    ## Sequential
    # sequential_link.(link)
    ## Thread
    threads << thread_link.(link)
    ## Fiber (Not same result, fibers are used differently)
    # fibers << fiber_link.(link)
  end
  # fibers.map(&:resume)
  threads.map(&:join)
end


puts "total --> #{data.length}"
puts "Time: #{Time.now - started_at}"