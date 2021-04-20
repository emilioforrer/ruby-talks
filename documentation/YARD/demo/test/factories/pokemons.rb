FactoryBot.define do
  factory :pokemon do
    name { "MyString" }
    total { 1 }
    hp { "" }
    attack { "" }
    defense { 1 }
    generation { 1 }
    legendary { false }
    types { nil }
  end
end
