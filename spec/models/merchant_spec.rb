require "rails_helper"

RSpec.describe Merchant, type: :model do

  describe "relationships" do
    it { should have_many(:items) }
    it { should have_many(:invoices).through(:items) }
    it { should have_many(:customers).through(:invoices) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe '#top_5_customers_from_transactions' do
    it 'will list top 5 customers based on item purchases through invoices' do
      test_data
      expected_order = [@customer1, @customer2, @customer3, @customer4, @customer5]
      expect(@merchant1.top_5_customers_from_transactions).to eq(expected_order)
    end
  end

  describe '#popular_items' do
    before :each do
      test_data_2
    end
    it 'list popular items ordered by revenue' do
      test_data_2
      expect(@merchant1.popular_items).to eq([@item4, @item3, @item2, @item1, @item7])
    end
  end

  describe '#popular_merchants' do
    before(:each) do
      test_data_joseph
    end
    
    it "returns the top 5 merchants based off revenue generated" do
      expect(Merchant.popular_merchants.sort).to eq([@merchant1, @merchant2, @merchant3, @merchant4, @merchant5])
    end
  end

  describe '#items_ready_to_ship_ordered_oldest_to_newest' do
    it 'list items ready to be shipped ordered by oldest to newest' do
      test_data_3
      expect(@merchant1.items_ready_to_ship_ordered_oldest_to_newest).to eq([#<Item:0x00000001203f0c98
      id: 9240,
      name: "Bat",
      unit_price: 6002,
      created_at: Tue, 07 Nov 2023 21:00:46.231370000 UTC +00:00,
      updated_at: Tue, 07 Nov 2023 21:00:46.231370000 UTC +00:00>,
     #<Item:0x00000001203f0b58
      id: 9241,
      name: "Cat",
      unit_price: 5089,
      created_at: Tue, 07 Nov 2023 21:00:46.232146000 UTC +00:00,
      updated_at: Tue, 07 Nov 2023 21:00:46.232146000 UTC +00:00>,
     #<Item:0x00000001203f0a18
      id: 9244,
      name: "Zat",
      unit_price: 5018,
      created_at: Tue, 07 Nov 2023 21:00:46.234368000 UTC +00:00,
      updated_at: Tue, 07 Nov 2023 21:00:46.234368000 UTC +00:00>])
    end
  end

  describe "#self.sort_alphabetical" do
    it "should sort the merchant data alphabetically" do
      merchant1 = Merchant.create!(name: "Sooyung LLC", created_at: Time.new(2010, 10, 2))
      merchant2 = Merchant.create!(name: "Joseph LLC", created_at: Time.new(2011, 10, 2))
      merchant3 = Merchant.create!(name: "Anthea LLC", created_at: Time.new(2012, 10, 2))
      merchant4 = Merchant.create!(name: "Nathan LLC", created_at: Time.new(2013, 10, 2))

      alphabetical = Merchant.all.sort_by{|m| -m.name}
      expect(Merchant.sort_alphabetical).to eq(alphabetical)
    end
  end 

  describe "#self.sort_by_date" do
    it "should sort the invoice data alphabetically" do
      merchant1 = Merchant.create!(name: "Sooyung LLC", created_at: Time.new(2010, 10, 2))
      merchant2 = Merchant.create!(name: "Joseph LLC", created_at: Time.new(2011, 10, 2))
      merchant3 = Merchant.create!(name: "Anthea LLC", created_at: Time.new(2012, 10, 2))
      merchant4 = Merchant.create!(name: "Nathan LLC", created_at: Time.new(2013, 10, 2))

      order = [merchant4, merchant3, merchant2, merchant1]
      expect(Merchant.sort_by_date).to eq(order)
    end
  end 
end
