class BulkDiscountsController < ApplicationController
  def index
    @discounts = BulkDiscount.all
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @discount = BulkDiscount.find(params[:id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def edit
    @discount = BulkDiscount.find(params[:id])
  end

  def update
    discount = BulkDiscount.find(params[:id])
    merchant = Merchant.find(params[:merchant_id])
    if discount.update(discount_params)
      redirect_to merchant_bulk_discount_path(merchant, discount)
    else
      redirect_to edit_merchant_bulk_discount_path(merchant, discount)
      flash[:alert] = "Error: Fill in all criteria with valid integer"
    end
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    discount = merchant.bulk_discounts.new(discount_params)
    if discount.save
      redirect_to merchant_bulk_discounts_path(merchant)
    else
      redirect_to new_merchant_bulk_discount_path(merchant)
      flash[:alert] = "Error: Fill in all criteria with valid integer"
    end
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])
    BulkDiscount.find(params[:id]).destroy
    redirect_to merchant_bulk_discounts_path(merchant)
  end

  private
  
  def discount_params
    params.permit(:discount_percent, :threshold, :merchant_id)
  end
end