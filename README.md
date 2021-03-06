# GlobalpayRubyGem

GlobalpayRubyGem is a Ruby Gem for using the [Globalpay] API


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'globalpay_ruby_gem'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install globalpay_ruby_gem

## Usage
*	The steps for carrying out a transaction is as follows:
* 	1. Get an access token by calling the Client Authorisation method
*	2. Use the access_token to send initiate your transaction by calling the Transaction initiaion method
* 	3. Redirect to GlobalPay transaction interface using the redirectUri retured in the Transaction initiation call
* 	4. After transaction has been done, you will be redirected to the provided redirectUrl provided with the transactionReference as a querystring
*	5. Validate the result by using the Retrieve transaction call

### Client Authentication
	globalpay_ruby_gem.authenticate(client_id,client_secret,is_live{Bool isLive : #True for for live enviroment and false for staging default value false});
})


### Transaction Initialization
	response = globalpay_ruby_gem.initialize_transaction(access_token,returnurl,merchantreference,merchantid,description,currencycode{eg NGN for naira},totalamount,customeremail,customernumber,customerfirstname,customerlastname,is_live{Bool isLive : #True for for live enviroment and false for staging default value false});
                                                                                                                                                                                                                 })


### Transaction Verification
	globalpay_ruby_gem.retrieve(access_token,merchantid,merchantreference,transactionrequest,is_live{Bool isLive : #True for for live enviroment and false for staging default value false})

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/globalpay_ruby_gem. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

