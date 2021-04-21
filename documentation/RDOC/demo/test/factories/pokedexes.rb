FactoryBot.define do
  factory :pokedex do
    association :user
    association :pokemon
  end
end
