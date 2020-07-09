module V1
  class Account
    attr_reader :amount
    
    def initialize(initial_amount)
      @amount = initial_amount
    end
  
    def debit(amount)
      @amount -= amount
    end
  
    def credit(amount)
      @amount += amount
    end
  end
end

module V2
  class Account
    attr_reader :amount
    
    def initialize(initial_amount)
      @amount = initial_amount
      @mutex = Mutex.new
    end
  
    def debit(amount)
      @mutex.synchronize do
        @amount -= amount
      end
    end
  
    def credit(amount)
      @mutex.synchronize do
        @amount += amount
      end
    end
  end
end

module V3
  class Account
    attr_reader :amount, :mutex
    
    def initialize(initial_amount)
      @amount = initial_amount
      @mutex = Mutex.new
    end
  
    def debit(amount)
      @amount -= amount
    end
  
    def credit(amount)
      @amount += amount
    end

    def synchronize(&block)
      @mutex.synchronize(&block)
    end
  end
end

class Order
  attr_accessor :amount, :status

  def initialize(amount, status)
    @amount, @status = amount, status
  end

  def pending?
    status == 'pending'
  end

  def complete!
    puts "Processing payment"
    self.status = 'paid'
    puts "Order completed"
  end
end


class Phone
  attr_accessor :owner, :mutex

  def initialize(spouse)
    @owner = spouse
    @mutex = Mutex.new
  end

  def hang
    mutex.synchronize do
      puts "#{owner.name} has hung up"
    end
  end
end

class Person
  attr_accessor :bored, :name

  def initialize(name, bored = false)
    @name = name
    @bored = bored
  end

  def talks_with(phone, person)
    while !bored
      if self != phone.owner
        sleep(1) # blocks thread, not process
        next
      end

      if !person.bored
          puts "#{name} you hang up first, #{person.name}"
          phone.owner = person
      else
        # Person was bored, hung up
        phone.hang()
        puts "#{name} I'm bored, #{person.name}"
        phone.owner = person
        @bored = true
      end
    end
  end
end