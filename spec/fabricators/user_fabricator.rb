Fabricator(:user) do
  name { Faker::Lorem.words(2).join(" ") }
  email { Faker::Internet.email }
  password { Faker::Internet.password(10) }
end