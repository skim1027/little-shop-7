class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  enum status: {"pending": 0, "packaged": 1, "shipped": 2}

  validates :invoice_id, presence: true, numericality: true
  validates :item_id, presence: true, numericality: true
  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true
  validates :status, presence: true
  
  def price
    (unit_price * 0.01).round(2)
  end

  def self.total_revenue
    InvoiceItem.sum("unit_price * quantity") * 0.01
  end

  def self.discounted_revenue(invoice_id)
    data = find_by_sql("select sum(quantity * unit_price * discount_percent) from (SELECT invoice_items.quantity, invoice_items.unit_price, invoice_items.invoice_id, invoices.id, cast((bulk_discounts.discount_percent) as decimal)/100 as discount_percent, invoice_items.item_id, rank() over(partition by item_id order by discount_percent desc) as rank FROM invoices Inner Join invoice_items on invoices.id = invoice_items.invoice_id INNER JOIN items ON items.id = invoice_items.item_id INNER JOIN merchants ON merchants.id = items.merchant_id INNER JOIN bulk_discounts ON bulk_discounts.merchant_id = merchants.id where quantity >= threshold and invoices.id = #{invoice_id}) as a where rank = 1").first.sum
    if data != nil
      data/100
    end
  end

  def self.total_discount_revenue(invoice_id)
    total_revenue - discounted_revenue(invoice_id)
  end
  
  def top_discount
    thresholds = item.merchant.bulk_discounts
    applicable_thresholds = []

    thresholds.each do |threshold|
      if quantity >= threshold.threshold
        applicable_thresholds << threshold
      end
    end
    
    max_discount_percent = applicable_thresholds.pluck(:discount_percent).max

    maximum_discount = []

    thresholds.each do |discount|
      if discount.discount_percent == max_discount_percent
        maximum_discount << discount
      end
    end
    maximum_discount.pick(:id)
    
      # InvoiceItem.joins(item: { merchant: :bulk_discounts}).select("bulk_discounts.*").where("invoice_items.quantity >= bulk_discounts.threshold").order("bulk_discounts.threshold DESC").first.attributes["id"]

    # find_by_sql("select bulk_id, max(discount_percent) from(select bulk_discounts.discount_percent, bulk_discounts.threshold, items.id, bulk_discounts.id as bulk_id from bulk_discounts INNER JOIN merchants ON merchants.id = bulk_discounts.merchant_id INNER JOIN items ON merchants.id = items.merchant_id INNER JOIN invoice_items ON items.id = invoice_items.item_id where invoice_items.quantity >= bulk_discounts.threshold order by bulk_discounts.threshold desc) as a group by bulk_id").first.bulk_id
    

  end
end


