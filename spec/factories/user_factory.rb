FactoryBot.define do
  factory User do
    username { FFaker::Internet.user_name }
    password { "password1" }
    email { FFaker::Internet.free_email }
    role { "default" }
  end
end