require 'savon'
Dir[File.join(__dir__, 'model/**', '*.rb')].each { |file| require file }

class SoapClient

  attr_accessor :wsdl

  def initialize(wsdl='https://www.crcind.com/csp/samples/SOAP.Demo.CLS?WSDL=1')
    @wsdl = wsdl
    @client_instance =  Savon.client(wsdl: @wsdl)
  end

  def print_operations
    puts "---------------\nWEB SERVICE OPERATIONS: \n\n#{@client_instance.operations.join("\n")}\n---------------\n"
  end

  def add_integer(n1: nil, n2: nil)
    message = Model::Request::AddInteger.new(n1, n2)
    result = @client_instance.call(:add_integer, message: message.to_message)
    Model::Response::AddIntegerResponseBuilder.from_message(result.body)
  end

  def find_person(id: nil)
    message = Model::Request::FindPerson.new(id)
    result = @client_instance.call(:find_person, message: message.to_message)
    Model::Response::FindPersonResponseBuilder.from_message(result.body)
  end

  def list_by_name(query: nil)
    message = Model::Request::ListByName.new(query)
    result = @client_instance.call(:get_list_by_name, message: message.to_message)
    Model::Response::ListByNameResponseBuilder.from_message(result.body)
  end
end

# client initialization using WSDL file
#client =  Savon.client(wsdl: 'https://www.crcind.com/csp/samples/SOAP.Demo.CLS?WSDL=1')

# listing client operations
#puts "List of operations: \n#{client.operations}"

# First Operation
#puts 'Add integer:'
# add_integer_message = Model::Request::AddInteger.new(1, 2)
#add_integer_message = Model::Request::AddInteger.new(1, nil)
#result = client.call(:add_integer, message: add_integer_message.to_message)
#add_integer_response_message = Model::Response::AddIntegerResponseBuilder.from_message(result.body)
#puts add_integer_response_message.result


# Second Operation
#puts 'Find person:'
#find_person_message = Model::Request::FindPerson.new(1)
#result = client.call(:find_person, message: find_person_message.to_message)
#find_person_response_message = Model::Response::FindPersonResponseBuilder.from_message(result.body)
#puts find_person_response_message.inspect

# Third Operation
#puts 'List by name:'
#list_by_name_message = Model::Request::ListByName.new('f')
#result = client.call(:get_list_by_name, message: list_by_name_message.to_message)
##puts result.body
#list_by_name_response_message = Model::Response::ListByNameResponseBuilder.from_message(result.body)
#puts list_by_name_response_message.inspect
