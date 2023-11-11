class BulkDiscountsController < ApplicationController
  def index
    @discounts = BulkDiscount.all
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    discount = merchant.bulk_discounts.create(discount_params)
    redirect_to merchant_bulk_discounts_path(merchant)
  end

  private
  
  def discount_params
    params.permit(:discount_percent, :threshold, :merchant_id)
  end
end