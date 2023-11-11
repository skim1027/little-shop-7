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

      it 'has a link to create a new discount, link takes you to a new page, when you submit new discount, it re-routes to index page' do
        # Solo US 2
        visit merchant_bulk_discounts_path(@merchant1)

        expect(page).to have_link("Create a New Discount")

        click_link("Create a New Discount")

        expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))

        expect(page).to have_field("Discount Percent")
        expect(page).to have_field("Quantity Threshold")

        fill_in("Discount Percent", with: 40)
        fill_in("Quantity Threshold", with: 40)

        click_button("Submit")

        expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
        
        new_discount = @merchant1.bulk_discounts.last

        within("#discount-#{new_discount.id}") do
          expect(page).to have_content("Discount Percent: 40")
          expect(page).to have_content("Quantity Threshold: 40")
        end
      end

      it 'needs all field filled in to create new discount' do
        # Solo US 2
        visit new_merchant_bulk_discount_path(@merchant1)

        fill_in("Discount Percent", with: 40)

        click_button("Submit")

        expect(current_path).to eq(new_merchant_bulk_discount_path(@merchant1))
        expect(page).to have_content("Error: Fill in all criteria with integer")
      end

      it 'can delete discount, and redirect to discount index page' do
        # Solo US 3
        visit merchant_bulk_discounts_path(@merchant1)
        
        within("#discount-#{@disc1.id}") do
          expect(page).to have_content("Delete")
          
          click_button("Delete")
        end

        expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
        expect(page).to_not have_content("Discount Number: #{@disc1.id}")
      end
    end
  end
end