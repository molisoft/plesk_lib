require 'active_support/core_ext/object/blank'
require 'plesk_lib/version'
# require 'plesk_lib/communicator'
require 'plesk_lib/customer_account'
# require 'plesk_lib/reseller_account'
require 'plesk_lib/actions/create_customer_account'
require 'plesk_lib/actions/change_customer_account_password'
require 'plesk_lib/server'
# require 'plesk_lib/service_plan'
# require 'plesk_lib/subscription'

module PleskLib
  class LoginAlreadyTaken < RuntimeError ; end
  class AccountNotFound < RuntimeError ; end
end
