module ViewModels
  class Base  < ::Cell::ViewModel
    include Cell::Hamlit
    include ActionView::Helpers::TranslationHelper
    include ::Cell::Translation
  end
end