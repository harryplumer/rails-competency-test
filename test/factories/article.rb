FactoryBot.define do
  factory :article do
    title { Faker::Lorem.words(4).join(" ")}
    content  { Faker::Lorem.paragraphs(10).join(" ") }
  end
end