module SsmParamsLoader
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      desc "Generates the SSM Params Loader config file."

      def self.source_root
        @_config_source_root ||= File.expand_path("../templates", __FILE__)
      end

      def copy_settings
        template "config.yml", "config/ssm_params_loader.yml"
      end

      def modify_gitignore
        create_file '.gitignore' unless File.exist? '.gitignore'

        append_to_file '.gitignore' do
          "\n" +
            "# Ignore SSM Params Loader config file\n" +
            "config/ssm_params_loader.yml\n"
        end
      end
    end
  end
end
