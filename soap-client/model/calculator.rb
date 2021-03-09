require 'savon'

module Model
  class Calculator
    extend Savon::Model

    client wsdl: 'https://www.crcind.com/csp/samples/SOAP.Demo.CLS?WSDL=1'

    operations :add_integer

    def self.add_integer(n1: nil, n2: nil)
      result = super(message: {'Arg1' => n1, 'Arg2' => n2})
      result.body
    end
  end
end