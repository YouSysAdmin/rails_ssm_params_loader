require_relative 'lib/ssm_params_loader/version'

Gem::Specification.new do |spec|
  spec.name = "ssm_params_loader"
  spec.version = SsmParamsLoader::VERSION
  spec.authors = ["Oleksii Samoliuk"]
  spec.email = ["work@yousysadmin.com"]
  spec.summary = "Rails application parameters preloader"
  spec.description = "Preloads AWS SSM parameters as an environment variables"
  spec.homepage = "https://github.com/yousysadmin/rails_ssm_params_loader"
  spec.license = "MIT"

  spec.files = Dir["LICENSE.txt", "README.md", "lib/**/*", "bin/*"]
  spec.executables = spec.files.grep(%r{^bin/}).map { |f| File.basename(f) }

  spec.required_ruby_version = ">= 3.0.0"

  spec.add_dependency "aws-sdk-ssm", ">= 1.165.0"

  spec.metadata = {
    "rubygems_mfa_required" => "false",
    "github_repo" => "https://github.com/yousysadmin/rails_ssm_params_loader"
  }
end
