# -*- encoding: utf-8 -*-
# stub: plesk_lib 1.0.5 ruby lib

Gem::Specification.new do |s|
  s.name = "plesk_lib"
  s.version = "1.0.7"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Phillipp R\u{f6}ll"]
  s.date = "2017-03-18"
  s.description = "Add customers, resellers, service plans and subscriptions to plesk via the XML RPC API"
  s.email = ["phillipp.roell@trafficplex.de"]
  s.files = [".gitignore", ".idea/.name", ".idea/.rakeTasks", ".idea/encodings.xml", ".idea/misc.xml", ".idea/modules.xml", ".idea/plesk_lib.iml", ".idea/scopes/scope_settings.xml", ".idea/vcs.xml", ".idea/workspace.xml", ".rspec", ".travis.yml", "Gemfile", "LICENSE.txt", "README.md", "Rakefile", "lib/plesk_lib.rb", "lib/plesk_lib/account.rb", "lib/plesk_lib/actions/base.rb", "lib/plesk_lib/actions/change_customer_password.rb", "lib/plesk_lib/actions/change_customer_status.rb", "lib/plesk_lib/actions/change_customer_subscription_plan.rb", "lib/plesk_lib/actions/create_account.rb", "lib/plesk_lib/actions/create_customer.rb", "lib/plesk_lib/actions/create_reseller.rb", "lib/plesk_lib/actions/create_service_plan.rb", "lib/plesk_lib/actions/create_subscription.rb", "lib/plesk_lib/actions/delete_customer.rb", "lib/plesk_lib/actions/get_statistics.rb", "lib/plesk_lib/actions/list_customers.rb", "lib/plesk_lib/actions/list_service_plans.rb", "lib/plesk_lib/actions/list_subscriptions.rb", "lib/plesk_lib/customer.rb", "lib/plesk_lib/reseller.rb", "lib/plesk_lib/server.rb", "lib/plesk_lib/service_plan.rb", "lib/plesk_lib/subscription.rb", "lib/plesk_lib/version.rb", "plesk_lib.gemspec", "spec/actions/change_customer_password_spec.rb", "spec/actions/create_customer_spec.rb", "spec/actions/create_reseller_spec.rb", "spec/actions/create_service_plan_spec.rb", "spec/actions/create_subscription_spec.rb", "spec/actions/get_statistics_spec.rb", "spec/actions/list_customers_spec.rb", "spec/actions/list_service_plans_spec.rb", "spec/actions/list_subscriptions.rb", "spec/customer_spec.rb", "spec/reseller_spec.rb", "spec/server_spec.rb", "spec/spec_helper.rb", "spec/vcr/customer/change_password_existing_user.yml", "spec/vcr/customer/change_password_missing_user.yml", "spec/vcr/customer/list_customers.yml", "spec/vcr/customer/list_customers_filtered.yml", "spec/vcr/customer/minimal.yml", "spec/vcr/customer/minimal_exists.yml", "spec/vcr/customer/minimal_with_owner.yml", "spec/vcr/reseller/minimal.yml", "spec/vcr/reseller/minimal_exists.yml", "spec/vcr/server/get_statistics.yml", "spec/vcr/service_plan/create_minimal.yml", "spec/vcr/service_plan/create_minimal_with_owner.yml", "spec/vcr/service_plan/list_admin.yml", "spec/vcr/service_plan/list_all.yml", "spec/vcr/subscription/create.yml", "spec/vcr/subscription/list_subscriptions.yml", "spec/vcr/subscription/list_subscriptions_filtered.yml"]
  s.homepage = "https://github.com/phillipp/plesk_lib"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.5"
  s.summary = "Plesk 11 provisioning library. Extracted out of plesk_kit"
  s.test_files = ["spec/actions/change_customer_password_spec.rb", "spec/actions/create_customer_spec.rb", "spec/actions/create_reseller_spec.rb", "spec/actions/create_service_plan_spec.rb", "spec/actions/create_subscription_spec.rb", "spec/actions/get_statistics_spec.rb", "spec/actions/list_customers_spec.rb", "spec/actions/list_service_plans_spec.rb", "spec/actions/list_subscriptions.rb", "spec/customer_spec.rb", "spec/reseller_spec.rb", "spec/server_spec.rb", "spec/spec_helper.rb", "spec/vcr/customer/change_password_existing_user.yml", "spec/vcr/customer/change_password_missing_user.yml", "spec/vcr/customer/list_customers.yml", "spec/vcr/customer/list_customers_filtered.yml", "spec/vcr/customer/minimal.yml", "spec/vcr/customer/minimal_exists.yml", "spec/vcr/customer/minimal_with_owner.yml", "spec/vcr/reseller/minimal.yml", "spec/vcr/reseller/minimal_exists.yml", "spec/vcr/server/get_statistics.yml", "spec/vcr/service_plan/create_minimal.yml", "spec/vcr/service_plan/create_minimal_with_owner.yml", "spec/vcr/service_plan/list_admin.yml", "spec/vcr/service_plan/list_all.yml", "spec/vcr/subscription/create.yml", "spec/vcr/subscription/list_subscriptions.yml", "spec/vcr/subscription/list_subscriptions_filtered.yml"]

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, [">= 3.0.0"])
      s.add_runtime_dependency(%q<ox>, ["~> 2.1"])
      s.add_runtime_dependency(%q<builder>, [">= 3.0"])
      s.add_development_dependency(%q<bundler>, ["~> 1.5"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.14.1"])
      s.add_development_dependency(%q<vcr>, ["~> 2.8.0"])
      s.add_development_dependency(%q<webmock>, ["~> 1.17.4"])
      s.add_development_dependency(%q<pry>, ["~> 0.9.12.6"])
    else
      s.add_dependency(%q<activesupport>, [">= 3.0.0"])
      s.add_dependency(%q<ox>, ["~> 2.1"])
      s.add_dependency(%q<builder>, [">= 3.0"])
      s.add_dependency(%q<bundler>, ["~> 1.5"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.14.1"])
      s.add_dependency(%q<vcr>, ["~> 2.8.0"])
      s.add_dependency(%q<webmock>, ["~> 1.17.4"])
      s.add_dependency(%q<pry>, ["~> 0.9.12.6"])
    end
  else
    s.add_dependency(%q<activesupport>, [">= 3.0.0"])
    s.add_dependency(%q<ox>, ["~> 2.1"])
    s.add_dependency(%q<builder>, [">= 3.0"])
    s.add_dependency(%q<bundler>, ["~> 1.5"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.14.1"])
    s.add_dependency(%q<vcr>, ["~> 2.8.0"])
    s.add_dependency(%q<webmock>, ["~> 1.17.4"])
    s.add_dependency(%q<pry>, ["~> 0.9.12.6"])
  end
end
