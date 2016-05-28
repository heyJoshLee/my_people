require "spec_helper"

describe Event do

  it {should belong_to(:creator)}
 # it {should belong_to(:category)} No model yet
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:street_address) }
  it { should validate_presence_of(:zip_code) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:date_time) }
end