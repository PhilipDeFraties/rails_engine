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

  def find_all
    merchants = Merchant.search(search_params)
    render json: MerchantSerializer.new(merchants)
  end

  def find
    merchant = Merchant.search(params["name"]).first
    render json: MerchantSerializer.new(merchants)
  end

  private

  def merchant_params
    params.permit(:name)
  end

  def search_params
    params.permit(params.keys.first, params.values.first)
  end
end
