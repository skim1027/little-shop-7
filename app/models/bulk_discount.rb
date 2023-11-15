class BulkDiscount < ApplicationRecord
  belongs_to :merchant

  validates :discount_percent, presence: true, numericality: { in: 1..100 }
  validates :threshold, presence: true, numericality: { greater_than_or_equal_to: 1 }
end