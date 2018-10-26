FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "test user #{n}" }
    sequence(:email) { |n| "test-#{n}@example.com" }
    password { 'password' }
  end

  factory :admin_user, class: User do
    name { 'admin user' }
    email { 'admin@example.com' }
    password { 'password' }
    admin { true }
  end
end
