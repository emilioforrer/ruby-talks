module Operations
  module Users
    class List < Operations::Api::Finder

      pass :filter_by_name!, after: :default_scope!

      def default_scope!(ctx, model_class:, **)
        current_user = ctx[:current_user]
        if current_user
          ctx[:models] = ctx[:models].where("id != ?", current_user.id)
        end
      end

      def filter_by_name!(ctx, filter:, models:, **)
        if filter[:name].present?
          filter[:name].split(" ").each do |word|
            ctx[:models] = ctx[:models].where("name ILIKE ?", "%#{word.strip}%")
          end
        end
      end
    end
  end
end