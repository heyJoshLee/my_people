Fabricator(:rsvp) do
  event_id { Fabricate(:event).id }
  user_id { Fabricate(:user).id }
  going true
end