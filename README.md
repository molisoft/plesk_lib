# PleskLib [![Gem Version](https://badge.fury.io/rb/plesk_lib.png)](http://badge.fury.io/rb/plesk_lib)


In development, but usable. Tested against Plesk for Linux 11.5

As of release 2.0.0, PleskKit can cope with a fleet of plesk servers. It will select the server with the lowest RAM consumption which matches your current Rails.env and desired platform (i.e. windows or linux).


## Installation

Add this line to your application's Gemfile:

    gem 'plesk_kit'

And then execute:

    $ bundle


Once installed, you need to perform some migrations.

    $ rake plesk_kit:install:migrations
    $ rake db:migrate


## Configuration & Assumptions
Before this little gem can communicate with your plesk server, we need to learn about your server(s). Platform can be 'linux' or 'windows', environment can be any possible Rails.env value.
```
PleskKit::Server.create(:platform => 'linux', :environment => 'development', :host => '192.168.0.1', :username => 'admin', :password => 'yourPleskPassword', :ghostname => 'Anything you Want!')
```

## Usage
Service Plans:
Create a service plan record in the database, currently you can customise a few settings (mailboxes, :domains, :name, :traffic, :storage)
If this service plan is not found by name on the server which the gem is attempting to provision to, it will create the service plan before creating the subscription. Note: use "-1" for unlimited.
```
PleskKit::ServicePlan.create(:name => "My Plan", :mailboxes => "10", :storage => "21474836480", :domains => "1",  :traffic => "-1")
```

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
* Passwords are stored in the clear at the moment

## Upcoming Features/Enhancements
Some new features are slowly on the way, these include:
* Ability to query Server statistics / performance metrics
* Password Encryption, with the ability to shake your own salt
* Shiny Plesk-Look Interfaces
* More functional test/dummy app

If you have a suggestion for a new feature, either submit a pull request (as per 'Contributing' section below) or post a message and I'll get to it when I can.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

