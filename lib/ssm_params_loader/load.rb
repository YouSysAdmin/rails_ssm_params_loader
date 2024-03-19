require 'aws-sdk-ssm'

module SsmParamsLoader
  def self.fetch_params(config_file = nil)

    config_file = config_file || default_config_file

    unless File.exist?(config_file)
      # puts "SSM Params Loader config file #{config_file} not found"
      return
    end

    config = YAML.safe_load_file(config_file).with_indifferent_access

    ssm_paths = config[:ssm_store_paths] || nil
    additional = config[:additional_vars] || nil

    # Get secrets and set environment variables
    environments = load_secrets(ssm_paths, additional)
    environments.each { |secret| ENV["SSM_#{secret[:name].gsub('-', '_').upcase}"] = secret[:value] }
  end

  private

  # Setup the default path to the config file
  def self.default_config_file
    ::Rails.root.join('config/ssm_params_loader.yml')
  end

  # Get a hash array of secrets
  def self.load_secrets(ssm_paths, additional)
    secrets = []

    unless ssm_paths.nil?
      ssm_paths.each do |path|
        puts path
        secrets += from_ssm(path)
      end
    end

    unless additional.nil?
      secrets += additional_variables(additional)
    end

    secrets
  end

  # Get a hash array of secrets from the SSM
  def self.from_ssm(ssm_path)
    ssm_data = []
    ssm = Aws::SSM::Client.new
    ssm.get_parameters_by_path(
      path: ssm_path,
      with_decryption: true
    ).each do |response|
      ssm_data.push(*response['parameters'])
    end

    variables = []

    ssm_data.each do |secret|
      variables << { :name => secret.name.split('/')[-1], :value => secret.value }
    end

    variables
  end

  # Get a hash array of secrets from the config file (the `additional` section)
  def self.additional_variables(additional_variables)
    variables = []
    additional_variables.each do |var|
      variables << { :name => var['name'], :value => var['value'] }
    end

    variables
  end
end
