FactoryBot.define do
  factory :user do
    email {Faker::Internet.email}
    password  {"Testtest123!"}
    password_confirmation {"Testtest123!"}
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}

    trait :editor_user do 
      after(:create) do |user| 
        UserRole.create(user: user, role_id: ActiveRecord::FixtureSet.identify(:editor_role) )
      end
    end

    trait :user_user do 
      after(:create) do |user| 
        UserRole.create(user: user, role_id: ActiveRecord::FixtureSet.identify(:user_role))
      end
    end 
    
    trait :admin_user do 
      after(:create) do |user| 
        UserRole.create(user: user, role_id: ActiveRecord::FixtureSet.identify(:admin_role))
      end
    end 

  end
end