require "spec_helper"

describe Group do 

  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:creator_id) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:state) }
  it { should validate_presence_of(:country) }
  it { should validate_presence_of(:zip_code) }
  it { should validate_presence_of(:category_id) }
  it { should belong_to(:creator)}
  it { should belong_to(:category)}



end