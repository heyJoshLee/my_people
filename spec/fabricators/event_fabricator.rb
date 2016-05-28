Fabricator(:event) do
  name { Faker::Lorem.words(3).join(" ") }
  street_address { Faker::Address.street_address }
  zip_code { Faker::Address.zip }
  user_id { (1..10).to_a.sample}
  category_id { (1..10).to_a.sample}
  description { Faker::Lorem.paragraph(2) }
  date_time { Faker::Time.backward(14, :evening) }
end