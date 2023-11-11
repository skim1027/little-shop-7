require "rails_helper"

RSpec.describe "bulk discounts show page" do
  before :each do
    test_data_2 
  end

  describe 'as a visitor' do
    describe 'when I visit /merchants/:merchant_id/bulk_discounts/:discount_id' do
      it 'shows the discount quantity threshold and percentage discount' do
        visit merchant_bulk_discount_path(@merchant1, @disc1)

        expect(page).to have_content("Discount Number #{@disc1.id} Information")
        expect(page).to have_content("Discount Percent: #{@disc1.discount_percent}%")
        expect(page).to have_content("Quantity Threshold: #{@disc1.threshold} items")
      end
    end
  end
end