require_relative 'ssm_params_loader/load'

module SsmParamsLoader
  module Rails
    class Railtie < ::Rails::Railtie
      def setup_environment_variables
        SsmParamsLoader.fetch_params
      end

      config.before_initialize { setup_environment_variables }
    end
  end
end
