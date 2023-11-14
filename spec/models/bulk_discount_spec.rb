require "rails_helper"

RSpec.describe BulkDiscount, type: :model do
  before :each do
    test_data
  end

  describe "relationship" do
    it { should belong_to :merchant }
  end

  describe "validations" do
    it { should validate_presence_of(:discount_percent) }
    it { should validate_presence_of(:threshold) }
  end
end