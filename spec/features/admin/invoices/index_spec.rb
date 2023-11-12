require "rails_helper"

RSpec.describe "Admin Invoices Index" do
  before(:each) do
    test_data
  end

  ## USER STORY 32
  describe 'Invoice IDs and Individual Links' do
    before :each do
      @testing_invoices = @customer1.invoices.limit(5)
    end

    it 'when visiting the invoice index page, shows all invoice ids in the system' do
      visit "/admin/invoices"
      @testing_invoices.each do |i|
        expect(page).to have_content(i.id)
      end
    end

    it "has a link for each id listed that directs to that invoice show page" do
      visit "/admin/invoices"
      @testing_invoices.each do |i|
        click_link "Invoice ##{i.id}"
        expect(current_path).to eq("/admin/invoices/#{i.id}")
        visit "/admin/invoices"
      end
    end
  end

  ## EXTENSION 1-1
  describe 'Managing Invoice Statuses' do
    before :each do
      @index_invoice_test = @customer1.invoices.first
      @index_invoice_test.update(status: 0)
    end

    it "when visiting the index, can see each invoice status" do
      visit "/admin/invoices"
      within("#update_status-#{@index_invoice_test.id}") do
        expect(page).to have_content("Status: In Progress")
        select "Completed", :from => "status_update"
        click_button "Update Invoice Status"
        expect(current_path).to eq("/admin/invoices")
        expect(page).to have_content("Status: Completed")
      end
    end
  end

  ## EXTENSION 1-2 (ADMIN INVOICE)
  describe 'Sorting Option on Admin Invoice Index' do
    before :each do
      @customer1.invoices.each do |i|
        i.update(created_at: Time.new(2020, 10, 2))
      end

      @customer2.invoices.each do |i|
        i.update(created_at: Time.new(2023, 3, 9))
      end

      @customer3.invoices.each do |i|
        i.update(created_at: Time.new(2019, 12, 29))
      end
    end

    it "when visiting the index, have two button options for sorting" do
      visit "/admin/invoices"
      expect(page).to have_button("Sort Alphabetically, A-Z")
      expect(page).to have_button("Sort by Date, Newest-Oldest")      
    end

    it "can sort alphabetically A-Z" do
      visit "/admin/invoices"
      click_button "Sort Alphabetically, A-Z"
      expect(current_path).to eq("/admin/invoices")
      
      alphabetical = Invoice.all.sort
      count = alphabetical.length
      check = alphabetical.first.id.to_s
      num = 1
      count-1.times do
        compare = alphabetical[num].id.to_s
        expect(check).to appear_before(compare)
        num+=1
      end
    end

    it "can sort by date newest to oldest" do
      visit "/admin/invoices"
      click_button "Sort by Date, Newest-Oldest"
      expect(current_path).to eq("/admin/invoices")

      order = Invoice.all.sort_by{|i| -i.created_at.to_i}
      count = order.length
      check = order.first.id.to_s
      num = 1
      count-1.times do
        compare = order[num].id.to_s
        expect(check).to appear_before(compare)
        num+=1
      end
    end

  end


end