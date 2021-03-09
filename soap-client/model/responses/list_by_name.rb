module Model
  module Response
    class ListByName

      attr_reader :item_list

      def initialize(item_list)
        @item_list = item_list
      end
    end

    class PersonalIdentification
      attr_reader :id, :name, :ssn, :dob

      def initialize(id, name, ssn, dob)
        @id = id
        @name = name
        @ssn = ssn
        @dob = dob
      end
    end

    class ListByNameResponseBuilder
      def self.from_message(message)
        return ListByName.new([]) if message[:get_list_by_name_response][:get_list_by_name_result].blank?
        message_body = message[:get_list_by_name_response][:get_list_by_name_result][:person_identification]
        data = message_body.map { |elem| PersonalIdentification.new(elem[:id], elem[:name], elem[:ssn], elem[:dob]) }
        ListByName.new(data)
      end
    end
  end
end