Fabricator(:membership) do
  group_id { (1..10).to_a.sample }
  user_id { (1..10).to_a.sample }
  role { "user" }
end

Fabricator(:admin_membership, from: :membership) do
  role "admin"
end
