# Secrets
![Static Badge](https://img.shields.io/badge/Current%20version-0.0.1-green)
[![Static Badge](https://img.shields.io/badge/Github-Registry-green)](https://github.com/YouSysAdmin/rails_ssm_params_loader/pkgs/rubygems/ssm_params_loader)
[![Static Badge](https://img.shields.io/badge/RubyGems-Registry-green)](https://rubygems.org/gems/ssm_params_loader)

Load AWS SSM Parameters as Environment variables during a Rails application initializing.

**IMPORTANT:** You should be using an Instance IAM role for access to the AWS SSM

```
# AWS SSM:
/MyApp/production/My-Secrets = 123

# config/ssm_params_loader.yml:
store_path: '/MyApp/production'

# Result:
SSM_MY_SECRET=123

To all environment variables, automatically, adding prefix SSM_
```

## Setup
Add to your `Gemfile`:
```ruby
gem 'ssm_params_loader', '0.0.1'
```

Install config files:
```shell
bin/rails generate ssm_params_loader:install
```

## Config
File path: `config/ssm_params_loader.yml`
```yaml
# Path to a SSM parameters
store_path: '/my_app/staging'

# Additional static secrets list
# If a name is equal to a name obtained from the SSM, the value from the SSM is overwritten by a value from this list.
additional:
  - name: my_secreting_secret
    value: value_for_my_secreting_secret
```
[![SWUbanner](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner2-direct.svg)](https://github.com/vshymanskyy/StandWithUkraine/blob/main/docs/README.md)
