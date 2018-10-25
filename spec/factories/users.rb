FactoryBot.define do
  factory :user do
    name { 'test user' }
    email { 'test@example.com' }
    password { 'password' }
  end

  factory :admin_user, class: User do
    name { 'admin user' }
    email { 'admin@example.com' }
    password { 'password' }
    admin { true }
  end
end
