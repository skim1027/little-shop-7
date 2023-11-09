class UpdateBulkDiscounts < ActiveRecord::Migration[7.0]
  def change
    rename_column :bulk_discounts, :discount, :discount_percent
    add_column :bulk_discounts, :threshold, :boolean, :default => true
  end
end
