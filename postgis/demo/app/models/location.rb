class Location < ApplicationRecord
  def distance_from(point)
    distance_query = Arel::Nodes::NamedFunction.new('ST_Distance', [
      Arel::Nodes::Quoted.new(Factories::Geo.to_wkt(coords)),
      Arel::Nodes::Quoted.new(Factories::Geo.to_wkt(point)),
      Arel::Nodes::Quoted.new(true)
    ])
    self.class.select(
      distance_query.as("distance")
    ).first&.distance
  end

  class << self
    def plaza_san_benito
      where(name: "Plaza San Benito").first
    end

    def within(point, distance)
      where(
        Arel::Nodes::NamedFunction.new('ST_DWithin', [
          arel_table[:coords],
          Arel::Nodes::Quoted.new(Factories::Geo.to_wkt(point)),
          Arel::Nodes::Quoted.new(distance)]).to_sql
      )
      
      # where(
      #   'ST_DWithin(coords, :point, :distance)',
      #   { point:  Factories::Geo.to_wkt(point), distance: distance }
      # )
    end
  end
end
