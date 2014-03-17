# PleskLib [![Gem Version](https://badge.fury.io/rb/plesk_lib.png)](http://badge.fury.io/rb/plesk_lib)


In development, but usable. Tested against Plesk for Linux 11.5

As of release 2.0.0, PleskKit can cope with a fleet of plesk servers. It will select the server with the lowest RAM consumption which matches your current Rails.env and desired platform (i.e. windows or linux).


## Installation

Add this line to your application's Gemfile:

    gem 'plesk_kit'

And then execute:

    $ bundle


## Usage

Everything can be done through the server:

### Customers:

```
server = PleskLib::Server.new('192.168.0.1', 'admin', 'yourPleskPassword')

# Create customer accounts (add it to a reseller by adding owner_id: [x] to the options hash):
customer = PleskLib::Customer.new('user92', {password: 'foobar', person_name: 'foo'}) 
server.create_customer(customer)

# List customer accounts:
server.list_customers
```

### Resellers:

```
reseller_account = PleskLib::Reseller.new('reseller01', {password: 'foobar', person_name: 'foo'})  
server.create_reseller(reseller)
```

### Service Plans:

``` 
# Create a service plan:

service_plan = PleskLib::ServicePlan.new("My Plan", {mailboxes: 10, storage: 2.gigabytes, domains: 1, traffic: 30.gigabytes})
server.create_service_plan(service_plan)
```


To create a new subscription for a customer in Plesk:
```
PleskKit::Subscription.create(:customer_account_id => customer.id, :plan_name => 'Unlimited', :name => 'foobar.domain.com')
```

## How it works: 

Every operation on the server is implemented in an action class inside `lib/plesk_lib/actions`. Please refer to the action class for usage and/or inner workings and add or modify actions as you like.

## Contributing 

1. Fork it
2. Please test what you do:
    - Create your feature branch (`git checkout -b my-new-feature`)
    - **Test your changes and record a test with VCR**
3. Commit your changes (`git commit -am 'Add some feature'`) 
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
