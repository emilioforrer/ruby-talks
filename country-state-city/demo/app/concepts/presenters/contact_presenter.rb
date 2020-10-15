module Presenters
  class ContactPresenter < Presenters::BasePresenter
    property :uuid
    property :name
    collection :emails, decorator: Presenters::EmailPresenter, class: ::Email,
                if: ->(decorator:, **) { decorator.when_loaded?(:emails) }
    collection :phones, decorator: Presenters::PhonePresenter, class: ::Phone,
                if: ->(decorator:, **) { decorator.when_loaded?(:phones) }
    collection :addresses, decorator: Presenters::AddressPresenter, class: ::Address,
                if: ->(decorator:, **) { decorator.when_loaded?(:addresses) }
    # TODO: Task for the talk
    # * Add images to the contact

    def when_loaded?(name)
      represented.respond_to?(:association) && represented.association(name).loaded?
    end
  end
end

