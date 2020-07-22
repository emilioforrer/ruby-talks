class Api::V1::ContactsController < ActionController::API

  def index
    result = Operations::Contacts::List.(
      params: params,
      model_class: Contact,
      presenter_class: Presenters::ContactPresenter,
      default_scope: -> (scope) do
        scope.includes(:emails, :addresses, :phones)
      end
    )
    render json: result[:response]
  end

  def create
    result = Operations::Contacts::Create.(
      params: params,
      model_class: Contact,
      presenter_class: Presenters::ContactPresenter
    )
    render_result(result)
  end


  def update
    result = Operations::Contacts::Update.(
      params: params,
      model_class: Contact,
      presenter_class: Presenters::ContactPresenter
    )
    render_result(result)
  end

  private

  def render_result(result)
    if result.success?
      render json: result[:response]
    else
      render json: result[:errors]
    end
  end
end
