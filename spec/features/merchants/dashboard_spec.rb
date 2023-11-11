require "rails_helper"

RSpec.describe "Dashboard" do
  before :each do
    test_data 
    test_data_4
  end

  describe 'as a visitor' do
    describe 'when I visit /merchant/:merchant_id/dashboard' do
      it "shows the name of the merchant" do
        #US 1
        visit "/merchants/#{@merchant1.id}/dashboard"

        expect(page).to have_content(@merchant1.name)
        expect(page).to_not have_content(@merchant2.name)
      end

      it "has a link to merchant items and invoices indexes" do
        #US 2
        visit "/merchants/#{@merchant1.id}/dashboard"
        
        expect(page).to have_link("Merchant Items")
        expect(page).to have_link("Merchant Invoices")
        
        click_link("Merchant Items")
        
        expect(current_path).to eq("/merchants/#{@merchant1.id}/items")
        
        click_link("#{@item1.name}")
        
        expect(current_path).to eq("/merchants/#{@merchant1.id}/items/#{@item1.id}")
        
        expect(page).to have_content(@item1.name)
        
        visit "/merchants/#{@merchant1.id}/dashboard"
        
        
        click_link("Merchant Invoices")
        
        expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices")
        
        expect(page).to have_content(@incomplete.id)
        expect(page).to have_content(@incomplete2.id)
        
        click_link("#{@incomplete.id}")
        
        expect(current_path).to eq("/merchants/#{@merchant1.id}/invoices/#{@incomplete.id}")
        expect(page).to have_content(@incomplete.status)
      end
      
      it "has names of the top 5 customers with the count of their successful transactions" do
        # US 3
        visit "/merchants/#{@merchant1.id}/dashboard"

        expect(@customer1.name).to appear_before(@customer2.name)
        expect(@customer2.name).to appear_before(@customer3.name)
        expect(@customer3.name).to appear_before(@customer4.name)
        expect(@customer4.name).to appear_before(@customer5.name)
      end

      it 'includes number of successful transactions beside each customer name' do
        #US 3
        visit "/merchants/#{@merchant1.id}/dashboard"
        expected_order = [@customer1, @customer2, @customer3, @customer4, @customer5]
        
        expected_order.each do |c|
          expect(page).to have_content("#{c.transactions.count} purchases")
        end
      end

      it "has section for 'items ready to ship'" do
        #US 4
        
        visit "/merchants/#{@merchant11.id}/dashboard"
        
        expect(page).to have_content("Items Ready to Ship")
        
        within("#Items-Ready-to-Ship") do
          expect(page).to have_content(@item20.name)
          expect(page).to have_content(@item30.name)
          expect(page).to_not have_content(@item40.name)
        end

        within("#Items-Ready-to-Ship") do
          expect(page).to have_content(@invoice0.id)
        end

        click_link("#{@invoice0.id}", match: :first)
        expect(current_path).to eq("/merchants/#{@merchant11.id}/invoices/#{@invoice0.id}")
      end

      xit "in the section for 'items ready to ship' I see date invoice was created formatted like 'Monday, July 18, 2019' and ordered oldest to newest" do
        #US 5
     
        @invoice0.update(created_at: '1999-01-01 00:00:00')
        date = Date.today.strftime('%A, %B %e, %Y')

        visit "/merchants/#{@merchant11.id}/dashboard"
        expect(page).to have_content("Items Ready to Ship")
        expect(page).to have_content("Friday, January 1, 1999")
        save_and_open_page
        expect(@invoice0.created_at).to appear_before(@invoice7.created_at)
      end

      it 'has a link to view all discounts, link takes you to discounts index page' do
        #Solo US 1
        visit merchant_dashboard_index_path(@merchant1)

        expect(page).to have_link('View All My Discounts')

        click_link('View All My Discounts')

        expect(current_path).to eq(merchant_bulk_discounts_path(@merchant1))
      end
    end
  end
end