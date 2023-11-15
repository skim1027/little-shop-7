require "rails_helper"

RSpec.describe InvoiceItem, type: :model do
  describe "relationships" do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
  end

  describe "validations" do
    it { should validate_presence_of(:invoice_id) }
    it { should validate_numericality_of(:invoice_id) }
    it { should validate_presence_of(:item_id) }
    it { should validate_numericality_of(:item_id) }
    it { should validate_presence_of(:quantity) }
    it { should validate_numericality_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_numericality_of(:unit_price) }
    it { should validate_presence_of(:status) }
    it { should define_enum_for(:status).with_values(pending: 0, packaged: 1, shipped: 2) }
  end

  describe '#price' do
    it 'returns the invoice item unit price with a decimal' do
      test_data 
      testing_invoice = create(:invoice_item, unit_price: 2599)
      expect(testing_invoice.price).to eq(25.99)
    end
  end

  describe 'discounted_revenue' do
    it 'shows the discounted amount from the invoice' do
      test_data_4
      expect(@invoice30.invoice_items.discounted_revenue(@invoice30.id)).to eq(17.00)
    end
  end

  describe 'total_revenue' do
    it 'calculates total revenue of the invoice' do
      test_data_4
      expect(@invoice30.invoice_items.total_revenue).to eq(105.00)
    end
  end

  describe 'total_discount_revenue' do
    it 'calculates revenue with discounts applied' do
      test_data_4
      expect(@invoice30.invoice_items.total_discount_revenue(@invoice30.id)).to eq(88.00)
    end
  end
  describe 'top_discount' do
    it 'gives the bulk_discounts id of the top discount applied' do
      test_data_4
      expect(@invoice_item91.top_discount).to eq(@disc3.id)
    end
  end
end