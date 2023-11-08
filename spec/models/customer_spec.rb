require "rails_helper"

RSpec.describe Customer, type: :model do
  before :each do
    test_data
  end

  describe "relationships" do
    it { should have_many(:invoices) }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe "validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe "#name" do
    it "will return the first and last name of the customer as one" do
      customer = create(:customer)
      full_name = customer.first_name + " " + customer.last_name
      expect(customer.name).to eq(full_name)
    end
  end
  
  describe "self.top_5_by_transaction" do
    it "will return the top five customers per count of successful transactions" do
      expected_result = [@customer1, @customer2, @customer3, @customer4, @customer5]
      expect(Customer.top_5_by_transaction).to eq(expected_result)
    end
  end

  describe "total_successful" do
    it "will also return how many successful transactions there are per each customer" do
      expected_result = [@customer1, @customer2, @customer3, @customer4, @customer5]

      expected_result.each do |customer|
        expected_count = customer.transactions.where(result: 'success').count
        expect(customer.total_successful).to eq(expected_count)
      end
    end
  end
end