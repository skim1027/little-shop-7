class UpdateBulkDiscountsThreshold < ActiveRecord::Migration[7.0]
  def change
    remove_column :bulk_discounts, :threshold
    add_column :bulk_discounts, :threshold, :integer
  end
end
