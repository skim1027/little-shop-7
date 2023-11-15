require 'rails_helper'

RSpec.describe 'merchant invoices show page (/merchants/:merchant_id/invoices/:invoice_id)' do
  
  describe 'when I visit /merchants/:merchant_id/invoices/:invoice_id' do
    before :each do
      test_data_2
      @invoices = [@invoice1, @invoice2, @invoice3]
    end

    it 'shows all the invoices that include at least on of my merchant items' do
      #US 15
      visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"
      expect(page).to have_content(@invoice1.id)
      expect(page).to have_content(@invoice1.status)
      expect(page).to have_content(@invoice1.created_at.strftime('%A, %B %d, %Y'))
      expect(page).to have_content(@invoice1.customer.name)
    end
    
    
    it "shows item and invoice_item information on the invoice" do
      # US 16 
      visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"
      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item2.name)
      expect(page).to have_content(@item3.name)
      expect(page).to have_content(@item4.name)
      expect(page).to have_content(@item6.name)
      expect(page).to have_content(@item7.name)
      expect(page).to have_content(@item8.name)

      expect(page).to have_content(@item1.unit_price)
      expect(page).to have_content(@item2.unit_price)
      expect(page).to have_content(@item3.unit_price)
      expect(page).to have_content(@item4.unit_price)
      expect(page).to have_content(@item6.unit_price)
      expect(page).to have_content(@item7.unit_price)
      expect(page).to have_content(@item8.unit_price)

      expect(page).to have_content(@invoice_item1.status)
      expect(page).to have_content(@invoice_item2.status)
      expect(page).to have_content(@invoice_item3.status)
      expect(page).to have_content(@invoice_item4.status)
      expect(page).to have_content(@invoice_item6.status)
      expect(page).to have_content(@invoice_item7.status)
      expect(page).to have_content(@invoice_item8.status)

      expect(page).to have_content(@invoice_item1.quantity)
      expect(page).to have_content(@invoice_item2.quantity)
      expect(page).to have_content(@invoice_item3.quantity)
      expect(page).to have_content(@invoice_item4.quantity)
      expect(page).to have_content(@invoice_item6.quantity)
      expect(page).to have_content(@invoice_item7.quantity)
      expect(page).to have_content(@invoice_item8.quantity)
    end

    it "shows total revenue" do
      # US 17 
      visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"
      expect(page).to have_content("Total Revenue")
      expect(page).to have_content("$#{@invoice1.potential_revenue}")
    end

    it "has select field for each invoice_item status that can be updated" do
      # US 18
    @merchant1 = create(:merchant, name: "Target")
    @item1 = create(:item, name: "hat", description: "cool hat", unit_price: 10, merchant_id: @merchant1.id)
    @customer1 = create(:customer)
    @invoice1 = create(:invoice, status: 1, customer_id: @customer1.id)
    @invoice_item1 = InvoiceItem.create(item_id: @item1.id, invoice_id: @invoice1.id, quantity: 4, unit_price: 10, status: 0)
      visit "/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}"
      expect(page).to have_selector("select")
      expect(find("select").value).to eq(@invoice_item1.status)
      select "packaged", from: "status_update"
      click_button "Update Item Status"
      expect(page).to have_current_path("/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}")
      @invoice_item1.reload
      expect(@invoice_item1.status).to eq("packaged")
      select "shipped", from: "status_update"
      click_button "Update Item Status"
      expect(page).to have_current_path("/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}")
      @invoice_item1.reload
      expect(@invoice_item1.status).to eq("shipped")
      select "pending", from: "status_update"
      click_button "Update Item Status"
      expect(page).to have_current_path("/merchants/#{@merchant1.id}/invoices/#{@invoice1.id}")
      @invoice_item1.reload
      expect(@invoice_item1.status).to eq("pending")
    end
  end 

  describe 'as a visitor' do
    describe 'when I visit /merchants/:merchant_id/invoices/:invoice_id' do
      it 'shows total revenue and total discounted revenue' do
        test_data_4
        # Solo US 6
        visit merchant_invoice_path(@merchant90, @invoice30)
        expect(page).to have_content("Total Revenue: $#{@invoice30.potential_revenue}")
        
        expect(page).to have_content("Total Discounted Revenue: $#{@invoice30.invoice_items.total_discount_revenue(@invoice30.id)}")
      end

      it 'shows links to applied discounts' do
        # Solo US 7
        test_data_4
        visit merchant_invoice_path(@merchant90, @invoice30)

        within("#item-#{@item90.id}") do
          expect(page).to have_link("Discount Applied")
        end
        
        within("#item-#{@item92.id}") do
          expect(page).to have_link("Discount Applied")
        end
        
        within("#item-#{@item93.id}") do
          expect(page).to have_link("Discount Applied")
        end

        within("#item-#{@item91.id}") do
          expect(page).to_not have_link("Discount Applied")
          expect(page).to have_content("No discount applied")
        end
      end

      it 'applies better discount if there are multiple applicable' do
        test_data_4
        disc4 = @merchant90.bulk_discounts.create!(discount_percent: 25, threshold: 10)
        
        # Solo US 7
        # Item 92, quantity 20; discount 2 (discount_percent: 10, threshold: 20) and 4 (discount_percent: 25, threshold: 10) applies, discount 4 is better deal

        visit merchant_invoice_path(@merchant90, @invoice30)

        within("#item-#{@item92.id}") do
          expect(page).to have_link("Discount Applied")
          click_link("Discount Applied")
        end

        expect(current_path).to eq(merchant_bulk_discount_path(@merchant90, disc4))
      end
    end
  end
end

