require 'httparty'

# t.float :nbu_usd
# t.float :nbu_euro

# t.float :private_usd
# t.float :private_euro
module GetExchangeRate

  def self.get_rate
    if ExchangeRate.any?
      ExchangeRate.first.rate
    else
      nbu_rate
    end
    # 26
  end

  def self.set_usd_nbu_rate
    if nbu_rate
      if ExchangeRate.any?
        obj = ExchangeRate.first
        obj.rate = nbu_rate
        obj.save
      else
        obj = ExchangeRate.new
        obj.rate = nbu_rate
        obj.save
      end
    end
  end

  def self.nbu_rate
    rate_uris = ["http://bank.gov.ua/NBUStatService/v1/statdirectory/exchange?json", "https://api.privatbank.ua/p24api/pubinfo?json&exchange&coursid=5"]

    response_nbu = HTTParty.get('http://bank.gov.ua/NBUStatService/v1/statdirectory/exchange?json')
    data_nbu = JSON.parse(response_nbu.body)
    usd_nbu = data_nbu.select {|key| key["r030"] == 840 }

    usd_nbu[0]["rate"]
  end
end