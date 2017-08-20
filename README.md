# Capistrano::Webhooks

Webhooks for Capistrano.

## Installation

Add this line to your application's Gemfile under the 'development' group:

```ruby
gem 'capistrano-webhooks'
```

Execute:

```
bundle
```

Add this to `Capfile`:

```ruby
require 'capistrano/webhooks'
```

## Usage

Add this to `deploy.rb` or to stage configuration file.

```ruby
# Example
set :webhooks, 'http://example.com': {
  method: :post, # Request send method. POST by default
  payload: { user: fetch(:local_user) }, # Data will be sent 
  before: {
    'deploy:updating': {
      payload: { par1: 'val1' } # Override data
    }
  },
  after: {
    'deploy:finishing': {},
    'deploy:failed': { method: :get } # Override send method
  }
}
```

## Contributing

1. Fork it ( http://github.com/iamdeuterium/capistrano-webhooks/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request