class Invoice < ApplicationRecord
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions
  belongs_to :customer

  validates :customer_id, presence: true, numericality: true
  validates :status, presence: true

  enum status: {"in progress": 0, "completed": 1, "cancelled": 2}

  def self.incomplete_not_shipped
    Invoice.joins(items: :invoice_items)
           .where(invoice_items: {status: ["pending", "packaged"]})
           .distinct
           .order(created_at: :asc)
  end

  def format_date
    created_at.strftime('%A, %B %e, %Y')
  end

  def potential_revenue
    (invoice_items.sum("unit_price * quantity") * 0.01).round(2)
  end

  def discounted_revenue
    # InvoiceItem.select("invoice_items.id, ((invoice_items.quantity * invoice_items.unit_price) - ((invoice_items.quantity * invoice_items.unit_price) * (MAX(bulk_discounts.discount_percent)/100))) as discounted_revenue")
    # .joins(item: {merchant: :bulk_discounts})
    # .where('invoice_items.quantity >= bulk_discounts.threshold')
    # .group('invoice_items.id')
    # .sum(&:discounted_revenue)
    
    # require 'pry'; binding.pry
  end

  def self.sort_alphabetical
    Invoice.all.order(id: :asc)
  end

  def self.sort_by_date
    Invoice.all.order(created_at: :desc)
  end
  
end