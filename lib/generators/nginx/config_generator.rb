module Nginx
  class ConfigGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    argument :environment, type: :string, default: 'production'
    class_option :server_name, type: :string, default: nil, desc: "server name for nginx (e.g. www.example.com)"

    def config
      template "environment.conf.erb", "config/nginx/#{environment}.conf"
    end

    private

    def application_name
      Rails.application.class.parent_name.downcase
    end

    def name
      "#{application_name}_#{environment}"
    end

    def default_server_name
      if environment == 'production'
        "#{application_name}.ru"
      else
        "#{environment}.#{application_name}.ru"
      end
    end

    def server_name
      puts options.server_name
      options[:server_name] || default_server_name
    end
  end
end