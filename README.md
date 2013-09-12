# PleskKit [![Gem Version](https://badge.fury.io/rb/plesk_kit.png)](http://badge.fury.io/rb/plesk_kit)


In development, but usable. Tested against Plesk for Linux 11.5

## Installation

Add this line to your application's Gemfile:

    gem 'plesk_kit'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install plesk_kit

Once installed, you need to perform some migrations.
    $ rake plesk_kit:install:migrations
    $ rake db:migrate


## Configuration & Assumptions
Before this little gem can communication with your plesk server, we need to learn about your server.
```
PleskKit::Server.create(:environment => 'development', :host => '192.168.0.1', :username => 'admin', :password => 'yourPleskPassword', :ghostname => 'Anything you Want!')
```
I am assuming that you have created some service plans via the plesk GUI or some other mechanism (sadly, this gem isn't yet capable of helping you with this).
You will need to know the names of the service plans and/or reseller plans you would like to create.

## Usage
To create a Customer in Plesk:
```
customer = PleskKit::CustomerAccount.create(:pname => "FirstName LastName", :cname => "My Company", :login => "uniquelogin", :password => "s0m3P@55w0rd")
```

To create a new subscription for a customer in Plesk:
```
PleskKit::Subscription.create(:customer_account_id => customer.id, :plan_name => 'Unlimited', :name => 'foobar.domain.com')
```

To create a Reseller in Plesk:
```
PleskKit::ResellerAccount.create(:pname => "FirstName LastName", :cname => "My Company", :login => "uniquelogin", :password => "s0m3P@55w0rd", :plan_name => "My Reseller Plan")
```

## Current Issues:
* Only uses the first server in the db matching your Rails.env
* Passwords are stored in the clear at the moment

## Upcoming Features/Enhancements
Some new features are slowly on the way, these include:
* Automatic selection of the best server to provision a new customer to (currently, it will merely pick the first server matching the environment of your current Rails.env)
* Ability to query Server statistics / performance metrics
* Password Encryption, with the ability to shake your own salt

If you have a suggestion for a new feature, either submit a pull request (as per 'Contributing' section below) or post a message and I'll get to it when I can.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

