FactoryGirl.define do
  factory :place do
    name { Faker::FamilyGuy.location }
    city { Faker::Adress.city }
    tags { %w[restaurant pub coffe bar pizza beer live_music alcohol fastfood karaoke sushi].sample 3 }
    lat  { Faker::Address.latitude }
    lng  { Faker::Address.longitude }
  end
end
