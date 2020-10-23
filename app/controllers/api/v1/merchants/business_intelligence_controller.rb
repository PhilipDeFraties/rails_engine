class Api::V1::Merchants::BusinessIntelligenceController < ApplicationController

  def most_revenue
    merchants = Merchant.by_revenue(params[:quantity])
    render json: MerchantSerializer.new(merchants)
  end

end
