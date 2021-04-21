module Api
  module V1
    # Interact with users controller
    class UsersController < Api::V1::ApplicationController
      skip_before_action :require_data!, only: [:me]

      Paw::SwaggerDoc.endpoint(
        path: 'api/v1/users/me',
        method: 'get',
        summary: 'Users - Show user info',
        tags: [
          'api/v1/users'
        ],
        success_status: 200,
        error_responses: [401, 422, 500],
        presenter: Presenters::UserPresenter
      )

      def me
        result = Paw::Operations::Api::Finder.call(
          me_options.merge!(collection: false)
        )
        render json: result[:response]
      end

      private

      def me_options
        {
          params: { id: current_user.id },
          model_identifier: :id,
          model_class: User,
          presenter_class: Presenters::UserPresenter
        }
      end
    end
  end
end
