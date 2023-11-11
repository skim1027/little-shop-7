require "rails_helper"

RSpec.describe "bulk discounts index page" do
  before :each do
    test_data_2 
  end

  describe 'as a visitor' do
    describe 'when I visit /merchants/:merchant_id/bulk_discounts' do
      it 'shows all the discounts including percentage and thresholds' do
        # Solo US 1
        visit merchant_bulk_discounts_path(@merchant1)
      
        expect(page).to have_content("Bulk Discount A")
        expect(page).to have_content("Bulk Discount B")
        expect(page).to have_content("Bulk Discount C")
        
        discounts.each do |discount|
          within("#discount-#{discount.id}") do
            expect(page).to have_content("Discount Percent: #{discount.discount_percent}")
            expect(page).to have_content("Quantity Threshold: #{discount.threshold}")
          end
        end

        # within("#discount-#{@disc2.id}") do
        #   expect(page).to have_content("Discount Percent: #{@disc2.discount_percent}")
        #   expect(page).to have_content("Quantity Threshold: #{@disc2.threshold}")
        # end
        
        # within("#discount-#{@disc3.id}") do
        #   expect(page).to have_content("Discount Percent: #{@disc3.discount_percent}")
        #   expect(page).to have_content("Quantity Threshold: #{@disc3.threshold}")
        # end
      end

      it 'has a link to the discount show page' do
        # Solo US 1
        visit merchant_bulk_discounts_path(@merchant1)

        expect(page).to have_link("Bulk Discount A")
        expect(page).to have_link("Bulk Discount B")
        expect(page).to have_link("Bulk Discount D")
      end
    end
  end
end