require 'active_support/core_ext/object/blank'
require 'plesk_lib/version'
require 'plesk_lib/account'
require 'plesk_lib/customer'
require 'plesk_lib/reseller'
require 'plesk_lib/actions/create_customer'
require 'plesk_lib/actions/create_reseller'
require 'plesk_lib/actions/change_customer_password'
require 'plesk_lib/actions/get_statistics'
require 'plesk_lib/server'
# require 'plesk_lib/service_plan'
# require 'plesk_lib/subscription'

module PleskLib
  class LoginAlreadyTaken < RuntimeError ; end
  class AccountNotFound < RuntimeError ; end
end
