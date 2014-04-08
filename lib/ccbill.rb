require 'net/http'
require 'net/https'

class Ccbill

	URL = "https://bill.ccbill.com/jpost/signup.cgi"
	
  def initialize(clientAccnum, clientSubacc)
    @clientAccnum,@clientSubacc = clientAccnum, clientSubacc
  end

    def self.sign_up(clientAccnum, clientSubacc,formName,formPrice,formPeriod,currencyCode,params1,params2)
    ccbill_api = self.new(clientAccnum,clientSubacc)
    ccbill_api.sign_up(formName,formPrice,formPeriod,currencyCode,params1,params2)
  end

  def sign_up(formName,formPrice,formPeriod,currencyCode,params1,params2)
    # salt= "3qufIzhNheemjjWlX9vfNPmq"
    salt= "QcdVAZByrcfXlRh1vClAc+bE"
  	@formName=formName
  	@formPrice=formPrice
  	@formPeriod=formPeriod
  	@currencyCode=currencyCode
    @params1=params1
    @params2=params2
  	@formDigest= Digest::MD5.hexdigest(@formPrice.to_s+@formPeriod.to_s+@currencyCode.to_s+salt)
  	get_api_call(sign_up_args)
  end

  def get_api_call(args_hash)
    uri = URI.parse(URL)
    uri.query = URI.encode_www_form(args_hash)
    uri.to_s
  end


  private
    def sign_up_args
    {
    	"clientAccnum" => @clientAccnum,
    	"clientSubacc" =>@clientSubacc,
    	"formName" =>@formName,
    	"formPrice" =>@formPrice,
    	"formPeriod" =>@formPeriod,
    	"currencyCode" =>@currencyCode,
    	"formDigest" =>@formDigest,
      "params1" => @params1,
      "params2" => @params2
    }
    end
end