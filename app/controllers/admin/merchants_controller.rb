class Admin::MerchantsController < ApplicationController
  def new
  end

  def index
    if params[:order] == "alphabetical"
      @merchants = Merchant.sort_alphabetical
    elsif params[:order] == "date"
      @merchants = Merchant.sort_by_date
    else
      @merchants = Merchant.all
    end
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    @merchant = Merchant.find(params[:id])
    if params[:new_name].present?
      @merchant.update(name: params[:new_name])
      redirect_to "/admin/merchants/#{@merchant.id}"
      flash[:alert] = "Update Successful"
    end

    if params[:enable] == "no"
      @merchant.update(enabled: false)
      redirect_to "/admin/merchants"
    elsif params[:enable] == "yes"
      @merchant.update(enabled: true)     
      redirect_to "/admin/merchants"
    end
  end

  def create
    if params[:new_company_name] != ""
      Merchant.create!(name: params[:new_company_name], enabled: false)
      redirect_to "/admin/merchants"
    elsif params[:new_company_name] == ""
      redirect_to "/admin/merchants/new"
      flash[:alert] = "Company name cannot be empty"
    end  
  end
end
