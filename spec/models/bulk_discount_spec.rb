require "rails_helper"

RSpec.describe BulkDiscount, type: :model do
  before :each do
    test_data
  end

  describe "validation" do
    it { should belong_to :merchant }
  end

end