Fabricator(:category) do
  name { Faker::Lorem.words(3).join(" ") }
end