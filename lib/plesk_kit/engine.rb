module PleskKit
  class Engine < ::Rails::Engine
    isolate_namespace PleskKit
  end
  #
  #
  #
  #class Engine < Rails::Engine
  #
  #  initialize "plesk_kit.load_app_instance_data" do |app|
  #    TeamPage.setup do |config|
  #      config.app_root = app.root
  #    end
  #  end
  #
  #  initialize "plesk_kit.load_static_assets" do |app|
  #    app.middleware.use ::ActionDispatch::Static, "#{root}/public"
  #  end
  #
  #end


end
