module Unicorn
  class ConfigGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    argument :environment, type: :string, default: 'production'

    def config
      template "environment.rb.erb", "config/unicorn/#{environment}.rb"
    end

    private

    def application_name
      Rails.application.class.parent_name.downcase
    end

    def name
      "#{application_name}_#{environment}"
    end
  end
end