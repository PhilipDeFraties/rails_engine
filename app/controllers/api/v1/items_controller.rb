class Api::V1::ItemsController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.all)
  end

  def show
    render json: ItemSerializer.new(Item.find(params[:id]))
  end

  def create
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
    Item.create(item_params)
    render json: ItemSerializer.new(Item.last)
  end

  def destroy
    Item.destroy(params[:id])
  end

  def update
    render json: ItemSerializer.new(Item.update(params[:id], item_params))
  end

  def merchants
    merchant = Item.find(params["item_id"]).merchant
    render json: MerchantSerializer.new(merchant)
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :merchant_id)
  end
end
