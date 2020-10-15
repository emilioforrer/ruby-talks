module Presenters
  class BasePresenter < Representable::Decorator
    include Representable::JSON
  end
end