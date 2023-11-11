class BulkDiscount < ApplicationRecord
  belongs_to :merchant

  validates :discount_percent, presence: true, numericality: true
  validates :threshold, presence: true, numericality: true
end