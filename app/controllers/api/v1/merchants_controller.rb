class Api::V1::MerchantsController < ApplicationController

  def index
    render json: MerchantSerializer.new(Merchant.all)
  end

  def show
    render json: MerchantSerializer.new(Merchant.find(params[:id]))
  end

  def create
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
    Merchant.create(merchant_params)
    render json: MerchantSerializer.new(Merchant.last)
  end

  def destroy
    Merchant.destroy(params[:id])
  end

  def update
    render json: MerchantSerializer.new(Merchant.update(params[:id], merchant_params))
  end

  def items
    items = Merchant.find(params["merchant_id"]).items
    render json: ItemSerializer.new(items)
    # render json: Merchant.find(params["merchant_id"]).items
  end

  private

  def merchant_params
    params.permit(:name)
  end
end
