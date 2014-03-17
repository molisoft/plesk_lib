# PleskLib [![Gem Version](https://badge.fury.io/rb/plesk_lib.png)](http://badge.fury.io/rb/plesk_lib)

Under heavy development, but usable. Tested against Plesk for Linux 11.5

## Installation

Add this line to your application's Gemfile:

    gem 'plesk_lib'

And then execute:

    $ bundle


## Usage

Everything can be done through the server object:

```
server = PleskLib::Server.new('192.168.0.1', 'admin', 'yourPleskPassword')
response = server.get_statistics
response.statistics
```

### Customers:

```

# Create customer accounts (add it to a reseller by adding owner_id: [x] to the options hash):
customer = PleskLib::Customer.new('user92', {password: 'foobar', person_name: 'foo'}) 
response = server.create_customer(customer)
puts 'Plesk id:   ' + response.plesk_id
puts 'Plesk GUID: ' + response.guid

# List all customer accounts:
response = server.list_customers
response.customers.each { |customer| puts customer.company_name, customer.login }

# or just the customers of an owner by id:
response = server.list_customers(3)
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

### Subscriptions:

To create a new subscription for a customer in Plesk:

```
subscription_settings = { name: 'foo-domain.de', ip_address: '10.0.0.158',
                          owner_id: 3, service_plan_id: 10, ftp_login: 'ftp01',
                          ftp_password: 'ftpPass01' }
subscription = PleskLib::Subscription.new(subscription_settings)
server.create_subscription(subscription)
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


## Thanks

Special thanks to the `plesk_kit` gem by tresacton.
