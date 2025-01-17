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


# @merchant1 = Merchant.create!(name: "Hair Care")
# @merchant2 = Merchant.create!(name: "Jewelry")

# # Merchant 1 Items
# @item_1 = Item.create!(name: "Shampoo", description: "This washes your hair", unit_price: 10, merchant_id: @merchant1.id)
# @item_2 = Item.create!(name: "Conditioner", description: "This makes your hair shiny", unit_price: 8, merchant_id: @merchant1.id)
# @item_3 = Item.create!(name: "Brush", description: "This takes out tangles", unit_price: 5, merchant_id: @merchant1.id)
# @item_4 = Item.create!(name: "Hair tie", description: "This holds up your hair", unit_price: 1, merchant_id: @merchant1.id)
# @item_7 = Item.create!(name: "Scrunchie", description: "This holds up your hair but is bigger", unit_price: 3, merchant_id: @merchant1.id)
# @item_8 = Item.create!(name: "Butterfly Clip", description: "This holds up your hair but in a clip", unit_price: 5, merchant_id: @merchant1.id)

# # Merchant 2 Items
# @item_5 = Item.create!(name: "Bracelet", description: "Wrist bling", unit_price: 200, merchant_id: @merchant2.id)
# @item_6 = Item.create!(name: "Necklace", description: "Neck bling", unit_price: 300, merchant_id: @merchant2.id)

# @customer_1 = Customer.create!(first_name: "Joey", last_name: "Smith")
# @customer_2 = Customer.create!(first_name: "Cecilia", last_name: "Jones")
# @customer_3 = Customer.create!(first_name: "Mariah", last_name: "Carrey")
# @customer_4 = Customer.create!(first_name: "Leigh Ann", last_name: "Bron")
# @customer_5 = Customer.create!(first_name: "Sylvester", last_name: "Nader")
# @customer_6 = Customer.create!(first_name: "Herber", last_name: "Kuhn")

# # enum status: [:cancelled, :in_progress, :complete]
# @invoice_1 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-27 14:54:09")
# @invoice_2 = Invoice.create!(customer_id: @customer_1.id, status: 2, created_at: "2012-03-28 14:54:09")
# @invoice_3 = Invoice.create!(customer_id: @customer_2.id, status: 2)
# @invoice_4 = Invoice.create!(customer_id: @customer_3.id, status: 2)
# @invoice_5 = Invoice.create!(customer_id: @customer_4.id, status: 2)
# @invoice_6 = Invoice.create!(customer_id: @customer_5.id, status: 2)
# @invoice_7 = Invoice.create!(customer_id: @customer_6.id, status: 2)
# @invoice_8 = Invoice.create!(customer_id: @customer_6.id, status: 1)

# # enum status: [:pending, :packaged, :shipped]
# @ii_1 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_1.id, quantity: 9, unit_price: 10, status: 2) # 90
# @ii_11 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_8.id, quantity: 12, unit_price: 6, status: 1) # 72
# @ii_12 = InvoiceItem.create!(invoice_id: @invoice_1.id, item_id: @item_5.id, quantity: 1, unit_price: 200, status: 1) # 200

# @ii_2 = InvoiceItem.create!(invoice_id: @invoice_2.id, item_id: @item_1.id, quantity: 1, unit_price: 10, status: 2)
# @ii_3 = InvoiceItem.create!(invoice_id: @invoice_3.id, item_id: @item_2.id, quantity: 2, unit_price: 8, status: 2)
# @ii_4 = InvoiceItem.create!(invoice_id: @invoice_4.id, item_id: @item_3.id, quantity: 3, unit_price: 5, status: 1)
# @ii_6 = InvoiceItem.create!(invoice_id: @invoice_5.id, item_id: @item_4.id, quantity: 1, unit_price: 1, status: 1)
# @ii_7 = InvoiceItem.create!(invoice_id: @invoice_6.id, item_id: @item_7.id, quantity: 1, unit_price: 3, status: 1)
# @ii_8 = InvoiceItem.create!(invoice_id: @invoice_7.id, item_id: @item_8.id, quantity: 1, unit_price: 5, status: 1)
# @ii_9 = InvoiceItem.create!(invoice_id: @invoice_7.id, item_id: @item_4.id, quantity: 1, unit_price: 1, status: 1)
# @ii_10 = InvoiceItem.create!(invoice_id: @invoice_8.id, item_id: @item_5.id, quantity: 1, unit_price: 1, status: 1)

# # enum result: [:failed, :success]
# @transaction1 = Transaction.create!(credit_card_number: 203942, credit_card_expiration_date: "12/2024", result: 1, invoice_id: @invoice_1.id)
# @transaction2 = Transaction.create!(credit_card_number: 230948, credit_card_expiration_date: "12/2024", result: 1, invoice_id: @invoice_2.id)
# @transaction3 = Transaction.create!(credit_card_number: 234092, credit_card_expiration_date: "12/2024", result: 1, invoice_id: @invoice_3.id)
# @transaction4 = Transaction.create!(credit_card_number: 230429, credit_card_expiration_date: "12/2024", result: 1, invoice_id: @invoice_4.id)
# @transaction5 = Transaction.create!(credit_card_number: 102938, credit_card_expiration_date: "12/2024", result: 1, invoice_id: @invoice_5.id)
# @transaction6 = Transaction.create!(credit_card_number: 879799, credit_card_expiration_date: "12/2024", result: 0, invoice_id: @invoice_6.id)
# @transaction7 = Transaction.create!(credit_card_number: 203942, credit_card_expiration_date: "12/2024", result: 1, invoice_id: @invoice_7.id)
# @transaction8 = Transaction.create!(credit_card_number: 203942, credit_card_expiration_date: "12/2024", result: 1, invoice_id: @invoice_8.id)

# # # # Both discounts are for Merchant 1
# @discount_1 = BulkDiscount.create!(discount_percent: 20.0, threshold: 5, merchant: @merchant1)
# @discount_2 = BulkDiscount.create!(discount_percent: 15.0, threshold: 10, merchant: @merchant1)

# Math Stuff (Merchant 1, Invoice 1)
# $90 - 20% off ($18) = $72
# $72 - 20% off ($14.40) = $57.60 (Even though this item quantity qualifies for the 15% off for 10 or more, 15% of 72 is only -$10.80)
# Final total before discounts: $90 + $72 = $162
# Final total after discounts $72 + $57.60 = $129.60

# @merchant90 = Merchant.create(name: "Target")

# @customer90 = Customer.create(first_name: "Joey", last_name: "Smith")

# @disc1 = @merchant90.bulk_discounts.create!(discount_percent: 30, threshold: 50)
# @disc2 = @merchant90.bulk_discounts.create!(discount_percent: 30, threshold: 40)
# @disc3 = @merchant90.bulk_discounts.create!(discount_percent: 20, threshold: 30)
# @disc4 = @merchant90.bulk_discounts.create!(discount_percent: 10, threshold: 20)

# @item90 = Item.create(name: "hat", description: "cool hat", unit_price: 100, merchant_id: @merchant90.id)
# @item91 = Item.create(name: "straw", description: "it is for drinking", unit_price: 50, merchant_id: @merchant90.id)
# @item92 = Item.create(name: "phone", description: "retro phone", unit_price: 150, merchant_id: @merchant90.id)
# @item93 = Item.create(name: "bike", description: "mountain bike", unit_price: 100, merchant_id: @merchant90.id)

# @invoice30 = Invoice.create(status: 1, customer_id: @customer90.id, created_at: Time.new(2023, 1, 1)) #sunday
# @invoice31 = Invoice.create(status: 1, customer_id: @customer90.id, created_at: Time.new(2023, 1, 1)) #sunday

# @invoice_item91 = InvoiceItem.create(item_id: @item90.id, invoice_id: @invoice30.id, quantity: 40, unit_price: 100, status: 2)
# @invoice_item92 = InvoiceItem.create(item_id: @item91.id, invoice_id: @invoice30.id, quantity: 10, unit_price: 50, status: 2)
# @invoice_item93 = InvoiceItem.create(item_id: @item92.id, invoice_id: @invoice30.id, quantity: 20, unit_price: 150, status: 2)
# @invoice_item94 = InvoiceItem.create(item_id: @item93.id, invoice_id: @invoice30.id, quantity: 30, unit_price: 100, status: 2)

# @invoice_item95 = InvoiceItem.create(item_id: @item90.id, invoice_id: @invoice31.id, quantity: 30, unit_price: 50, status: 2)
# @invoice_item96 = InvoiceItem.create(item_id: @item91.id, invoice_id: @invoice31.id, quantity: 40, unit_price: 100, status: 2)
# @invoice_item96 = InvoiceItem.create(item_id: @item93.id, invoice_id: @invoice31.id, quantity: 50, unit_price: 150, status: 2)

# @transaction91 = Transaction.create(result: 1, invoice_id: @invoice30.id)
# @transaction92 = Transaction.create(result: 1, invoice_id: @invoice31.id)