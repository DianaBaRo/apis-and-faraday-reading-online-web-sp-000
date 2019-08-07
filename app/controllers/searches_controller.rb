class SearchesController < ApplicationController
  def search
  end

  def foursquare
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'MAA1FKPZWQN1VEDXMGXIEKEQJRLDKHDQTUEIDFIENC2NFRIU'
      req.params['client_secret'] = 'W4V403N1SIJRGWUEK04JO4ZYO1TQ2Z2O2CTE3CBNC3LZNQJU'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end

    body = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body["response"]["venues"]
    else
      @error = body["meta"]["errorDetail"]
    end
    render 'search'
  end
end
