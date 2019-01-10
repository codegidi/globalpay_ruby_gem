require 'httpclient'
require 'json'
require 'globalpay_ruby_gem/version'
require 'globalpay_ruby_gem/helpers/const'


module GlobalpayRubyGem
  extend self

  def authentication(*args)
    if args.size == 4
      GlobalpayRubyGem.authenticate_client(args[0],args[1],args[2])
    else
      response = "{'error':'parameters miss match, expecting 4 paramters'}"
    end
  end

  def initialize(*args)
    if args.size == 7
      GlobalpayRubyGem.initialize_transaction(args[0],args[1],args[2],args[3],args[4],args[5],args[6],args[7],args[8],args[9],args[10],args[11])
    else
      response = "{'error':'parameters miss match, expecting 7 paramters'}"
    end
  end

  def retrieve(*args)
    if args.size == 4
      GlobalpayRubyGem.retrieve_transaction(args[0],args[1],args[2],args[3],args[4])
    else
      response = "{'error':'parameters miss match, expecting 4 paramters'}"
    end
  end


  def authenticate_client(client_id,client_secret,is_live)
    http = HTTPClient.new
    body = 'client_id='+client_id+'&client_secret='+client_secret+'grant_type=client_credentials'
    header = { 'Content-Type' => 'application/x-www-form-urlencoded'}

    if is_live
      res = http.post(TOKEN_URL_LIVE, body)
    else
      res = http.post(TOKEN_URL_STAGING, body)
    end

    if res.successful?(res.status)
      res.body
    else
      response = "{'error':{'status':'#{res.status}','body':'#{res.body}'}}"
    end
  end

  def initialize_transaction(access_token,returnurl,merchantreference,merchantid,description,currencycode,totalamount,customeremail,customernumber,customerfirstname,customerlastname,is_live)
    http = HTTPClient.new
    body = { 'returnurl' => returnurl,'customerip' => '', 'merchantreference' => merchantreference, 'merchantid' => merchantid, 'description' => description,
             'currencycode' => currencycode, 'totalamount' => totalamount, 'customer' => { 'email' => customeremail,'firstname' => customerfirstname, 'lastname' => customerlastname, 'mobile' => customernumber },
             'paymentmethod' => 'card','transactionType' => 'Payment', 'connectionmode' => 'redirect', 'product' => [{'name' => description, 'unitprice' => totalamount,'quantity' => '1'}]}
    header = { 'Content-Type' => 'application/json', 'Authorization' => "Bearer #{access_token}"}

    if is_live
      res = http.post(BASE_URL_LIVE + '/SetRequest', body,header)
    else
      res = http.post(BASE_URL_STAGING + '/SetRequest', body,header)
    end

    if res.successful?(res.status)
      res.body
    else
      response = "{'error':{'status':'#{res.status}','body':'#{res.body}'}}"
    end
  end

  def retrieve_transaction(access_token,merchantid,merchantreference,transactionrequest,is_live)
    http = HTTPClient.new
    body = { 'merchantId' => merchantid, 'merchantreference' => merchantreference, 'transactionRequest' => transactionrequest}
    header = { 'Content-Type' => 'application/json', 'Authorization' => "Bearer #{access_token}"}

    if is_live
      res = http.post(BASE_URL_LIVE + '/Retrieve', body,header)
    else
      res = http.post(BASE_URL_STAGING + '/Retrieve', body,header)
    end

    if res.successful?(res.status)
      res.body
    else
      response = "{'error':{'status':'#{res.status}','body':'#{res.body}'}}"
    end
  end

end
