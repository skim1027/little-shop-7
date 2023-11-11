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
              
        within("#discount-#{@disc1.id}") do
        save_and_open_page
          expect(page).to have_content("Discount Number: #{@disc1.id}")
          expect(page).to have_content("Discount Percent: #{@disc1.discount_percent}%")
          expect(page).to have_content("Quantity Threshold: #{@disc1.threshold} items")
        end
      
        within("#discount-#{@disc2.id}") do
          expect(page).to have_content("Discount Number: #{@disc2.id}")
          expect(page).to have_content("Discount Percent: #{@disc2.discount_percent}%")
          expect(page).to have_content("Quantity Threshold: #{@disc2.threshold} items")
        end
    
        within("#discount-#{@disc3.id}") do
          expect(page).to have_content("Discount Number: #{@disc3.id}")
          expect(page).to have_content("Discount Percent: #{@disc3.discount_percent}%")
          expect(page).to have_content("Quantity Threshold: #{@disc3.threshold} items")
        end
      end

      it 'has a link to the discount show page' do
        # Solo US 1
        visit merchant_bulk_discounts_path(@merchant1)

        expect(page).to have_link("Discount Number: #{@disc1.id}")
        expect(page).to have_link("Discount Number: #{@disc2.id}")
        expect(page).to have_link("Discount Number: #{@disc3.id}")
      end
    end
  end
end