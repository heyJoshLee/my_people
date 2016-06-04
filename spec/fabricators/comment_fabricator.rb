Fabricator(:comment) do
  body { Faker::Lorem.paragraph(2) }
  user_id { (1..10).to_a.sample }
end
