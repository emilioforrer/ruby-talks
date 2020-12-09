class User < ApplicationRecord
  # set_rgeo_factory_for_column :coords, Factories::Geo.factory


  class << self
    def within_polygon(polygon)
      where(
        Arel::Nodes::NamedFunction.new('ST_Covers', [
          Arel::Nodes::Quoted.new(Factories::Geo.to_wkt(polygon)), # or polygon.as_text
          arel_table[:coords],
        ])
      )
      #  where('ST_Covers(:polygon, coords)', polygon: Factories::Geo.to_wkt(polygon))
    end

    def jane
      where(name: "Jane Smith").first
    end

    def barry
      where(name: "Barry Tone").first
    end

    def john
      where(name: "John Doe").first
    end
  end
end
