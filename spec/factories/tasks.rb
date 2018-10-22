FactoryBot.define do
  factory :task do
    name { 'write test' }
    description { 'Rspec Capybara FactoryBot initialize' }
    user
  end
end
