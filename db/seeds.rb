# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Transaction.destroy_all
Invoice.destroy_all
InvoiceItem.destroy_all
Item.destroy_all
Merchant.destroy_all
Customer.destroy_all

@merchant101 = Merchant.create(name: "Target")
@disc1 = @merchant101.bulk_discounts.create!(discount_percent: 30, threshold: 50)
@disc2 = @merchant101.bulk_discounts.create!(discount_percent: 10, threshold: 20)
@disc3 = @merchant101.bulk_discounts.create!(discount_percent: 20, threshold: 30)