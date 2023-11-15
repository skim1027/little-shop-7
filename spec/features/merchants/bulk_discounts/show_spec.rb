require "rails_helper"

RSpec.describe "bulk discounts show page" do
  before :each do
    test_data_2 
  end

  describe 'as a visitor' do
    describe 'when I visit /merchants/:merchant_id/bulk_discounts/:discount_id' do
      it 'shows the discount quantity threshold and percentage discount' do
        # Solo US 4
        visit merchant_bulk_discount_path(@merchant1, @disc1)

        expect(page).to have_content("Discount Number #{@disc1.id} Information")
        expect(page).to have_content("Discount Percent: #{@disc1.discount_percent}%")
        expect(page).to have_content("Quantity Threshold: #{@disc1.threshold} items")
      end

      it 'has an edit link, when clicked, shows pre-populated info, and when submitted, redirects to show page with updated info' do
        # Solo US 5
        visit merchant_bulk_discount_path(@merchant1, @disc1)

        expect(page).to have_content("Discount Percent: 30%")
        expect(page).to have_content("Quantity Threshold: 50 items")
        expect(page).to have_link("Edit Discount")

        click_link("Edit Discount")

        expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant1, @disc1))
        expect(page).to have_field("Discount Percent", with: @disc1.discount_percent)
        expect(page).to have_field("Quantity Threshold", with: @disc1.threshold)

        fill_in("Discount Percent", with: 35)
        fill_in("Quantity Threshold", with: 35)

        click_button("Submit")

        expect(current_path).to eq(merchant_bulk_discount_path(@merchant1, @disc1))
        expect(page).to have_content("Discount Percent: 35%")
        expect(page).to have_content("Quantity Threshold: 35 items")
      end

      it 'does not update if values are not valid' do
        # Solo US 5
        visit edit_merchant_bulk_discount_path(@merchant1, @disc1)
        
        fill_in("Discount Percent", with: 135)
        fill_in("Quantity Threshold", with: 0)

        click_button("Submit")
        
        expect(current_path).to eq(edit_merchant_bulk_discount_path(@merchant1, @disc1))
        
        expect(page).to have_content("Error: Fill in all criteria with valid integer")
      end
    end
  end
end