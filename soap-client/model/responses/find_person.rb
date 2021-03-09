module Model
  module Response
    class FindPerson

      attr_reader :name, :ssn, :dob, :home, :office, :favorite_colors, :age

      def initialize(name, ssn, dob, home, office, favorite_colors, age)
        @name = name
        @ssn = ssn
        @dob = dob
        @home = home
        @office = office
        @favorite_colors = favorite_colors
        @age = age
      end
    end

    class Place

      attr_reader :street, :city, :state, :zip

      def initialize(street, city, state, zip)
        @street = street
        @city = city
        @state = state
        @zip = zip
      end
    end

    class FindPersonResponseBuilder
      def self.from_message(message)
        data = message[:find_person_response][:find_person_result]
        return nil if data.blank?

        home = data[:home].blank? ? nil : Place.new(*data[:home].map { |k, v| v })
        office = data[:office].blank? ? nil : Place.new(*data[:office].map { |k, v| v })
        favorite_colors = data[:favorite_colors].blank? ? nil : data[:favorite_colors].map { |k, v| v }.flatten
        FindPerson.new(
          data[:name],
          data[:ssn],
          data[:dob],
          home,
          office,
          favorite_colors,
          data[:age]
        )
      end
    end
  end
end