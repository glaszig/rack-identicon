# Rack::Identicon

Rack middleware to generate identicons through the [identicon gem](https://rubygems.org/gems/identicon).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rack-identicon'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install rack-identicon

## Usage

Use the middleware with plain rack:

```rb
# config.ru
require "rack/identicon"
map("/__identicon__") { run Rack::Identicon.new }
run lambda { |env| [200, {'Content-Type' => 'text/plain'}, ['OK']] }
```

Use with Rails:

```rb
# config/routes.rb
Rails.application.routes.draw do
  mount Rack::Identicon.new, at: "/__identicon__", as: :identicon
end
```

### Caching

Rack::Identicon supports caching through any object implementing the methods
`read(key)`, `write(key, data)`, `exist?(key)` and `fetch(key, &blk)`.
When used with Rails it'll use `Rails.cache` automatically. Outside of Rails
you'll need to configure your cache store like this:

```rb
Rack::Identicon.cache_store = MyStore.new
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/glaszig/rack-identicon.


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
