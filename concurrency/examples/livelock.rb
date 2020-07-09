require 'thread'
require_relative "deps"

husband = Person.new("Jonh")
wife = Person.new("Jane")

phone = Phone.new(husband)

t1 = Thread.new do
  husband.talks_with(phone, wife)
end

t2 = Thread.new do
  wife.talks_with(phone, husband)
end

[t1, t2].map(&:join)