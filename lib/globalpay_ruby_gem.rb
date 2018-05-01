require 'httpclient'
require 'json'
require 'globalpay_ruby_gem/version'
require 'globalpay_ruby_gem/helpers/const'


module GlobalpayRubyGem
  extend self

  def authentication(*args)
    if args.size == 4
      GlobalpayRubyGem.authenticate_client(args[0],args[1],args[2],args[3])
    else
      response = "{'error':'parameters miss match, expecting 4 paramters'}"
    end
  end

  def initialize(*args)
    if args.size == 7
      GlobalpayRubyGem.initialize_transaction(args[0],args[1],args[2],args[3],args[4],args[5],args[6])
    else
      response = "{'error':'parameters miss match, expecting 7 paramters'}"
    end
  end

  def retrieve(*args)
    if args.size == 4
      GlobalpayRubyGem.retrieve_transaction(args[0],args[1],args[2],args[3])
    else
      response = "{'error':'parameters miss match, expecting 4 paramters'}"
    end
  end


  def authenticate_client(username,password,client_id,client_secret)
    http = HTTPClient.new
    body = { 'username' => username, 'password' => password, 'client_id' => client_id,
             'client_secret' => client_secret, 'grant_type' => 'password', 'scope' => 'globalpay_api'}
    res = http.post(TOKEN_URL, body)
    if res.successful?(res.status)
      res.body
    else
      response = "{'error':{'status':'#{res.status}','body':'#{res.body}'}}"
    end
  end

  def initialize_transaction(access_token,returnurl,merchantreference,description,currencycode,totalamount,customer)
    http = HTTPClient.new
    body = { 'returnurl' => returnurl, 'merchantreference' => merchantreference, 'description' => description,
             'currencycode' => currencycode, 'totalamount' => totalamount, 'customer' => customer,
             'customerip' => '', 'paymentmethod' => 'card','transactionType' => 'Payment', 'connectionmode' => 'redirect'}
    header = { 'Content-Type' => 'application/json', 'Authorization' => "Bearer #{access_token}"}
    res = http.post(BASE_URL + '/api/v3/Payment/SetRequest', body,header)
    if res.successful?(res.status)
      res.body
    else
      response = "{'error':{'status':'#{res.status}','body':'#{res.body}'}}"
    end
  end

  def retrieve_transaction(access_token,merchantid,merchantreference,transactionrequest)
    http = HTTPClient.new
    body = { 'merchantId' => merchantid, 'merchantreference' => merchantreference, 'transactionRequest' => transactionrequest}
    header = { 'Content-Type' => 'application/json', 'Authorization' => "Bearer #{access_token}"}
    res = http.post(BASE_URL + '/api/v3/Payment/Retrieve', body,header)
    if res.successful?(res.status)
      res.body
    else
      response = "{'error':{'status':'#{res.status}','body':'#{res.body}'}}"
    end
  end

end
