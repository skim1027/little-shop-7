require "rails_helper"

RSpec.describe "Admin Dashboard" do
  before :each do
    test_data
  end

  ## USER STORY 19
  it "displays a header indicating that I am on the admin dashboard" do
    visit "/admin"
    expect(page).to have_content("Admin Dashboard")
  end

  ## USER STORY 20
  it "when visiting the admin dashboard, it has a link for the admin merchants index" do
    visit "/admin"
    click_link("Merchants")
    expect(current_path).to eq("/admin/merchants")
  end

  it "has a link for the admin invoices index" do
    visit "/admin"
    click_link("Invoices")
    expect(current_path).to eq("/admin/invoices")
  end

  ## USER STORY 21
  it "when visiting the dashboard, the names of the top 5 customers with the largest number of successful transactions appears" do
    visit "/admin"
    expect(page).to have_content("Top 5 Customers")
    expect(@customer1.name).to appear_before(@customer2.name)
    expect(@customer2.name).to appear_before(@customer3.name)
    expect(@customer3.name).to appear_before(@customer4.name)
    expect(@customer4.name).to appear_before(@customer5.name)
  end

  it "also includes the number of successful transactions per each customer" do
    visit "/admin"
    expect(page).to have_content("Top 5 Customers")
    expected_results = Customer.top_5_by_transaction

    expected_results.each do |customer|
      within("#topcustomer-#{customer.id}") do
      expected_count = customer.transactions.where(result: 'success').count
        expect(page).to have_content(expected_count)
      end
    end
  end

  ## USER STORY 22
  it "has a section for incomplete invoices with a list of IDs of all invoices not shipped" do
    visit "/admin"
    expect(page).to have_content("Incomplete Invoices")
    @incomplete_results.each do |result|
      expect(page).to have_content(result.id)
    end
  end

  it "also includes invoice ID links to the invoice admin show page" do
    visit "/admin"
    click_link "Invoice ##{@incomplete.id}"
    expect(current_path).to eq("/admin/invoices/#{@incomplete.id}")
    visit "/admin"
    click_link "Invoice ##{@incomplete2.id}"
    expect(current_path).to eq("/admin/invoices/#{@incomplete2.id}")
  end

  ## USER STORY 23
  it "in the section for Incomplete Invoices lists the date that the invoice was created" do
    visit "/admin"
    expect(page).to have_content("Incomplete Invoices")
    expect(page).to have_content("Tuesday, March 9, 2021")
    expect(page).to have_content("Sunday, December 5, 2021")
    expect(page).to have_content("Thursday, February 4, 2021")
    visit "/admin/invoices/#{@incomplete.id}"
  end

  it "is placed in order from oldest to newest" do
    visit "/admin"
    expect("Invoice ##{@incomplete3.id}").to appear_before("Invoice ##{@incomplete.id}")
    expect("Invoice ##{@incomplete.id}").to appear_before("Invoice ##{@incomplete2.id}")
  end

end
