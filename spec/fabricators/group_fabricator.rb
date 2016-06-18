Fabricator(:group) do
  name { Faker::Lorem.words(3).join(" ")}
  description { Faker::Lorem.paragraphs(3) }
  creator_id { (1..20).to_a.sample }
  category_id { (1..20).to_a.sample }
  city  { Faker::Address.city }
  state { Faker::Address.state }
  zip_code { 71901 }

end