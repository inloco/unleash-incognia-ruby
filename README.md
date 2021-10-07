# Unleash::Incognia

This gem contains our Unleash custom strategies.

## Installation

You must set up [Unleash Ruby SDK](https://github.com/Unleash/unleash-client-ruby) in order to use these custom strategies.

Add this line to your application's Gemfile:

```ruby
gem 'unleash-incognia', '~> 0.1'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install unleash-incognia

## Usage

You must set up [Unleash Ruby SDK](https://github.com/Unleash/unleash-client-ruby) in order to use these custom strategies.

```ruby
> user = OpenStruct.new(id: 2, email: 'my@mail.com')
=> #<OpenStruct id=2, email="my@mail.com">

> Unleash::Incognia::Client.new(user: user).enabled_features
=> ["incognia_feature_1"]

> organization = OpenStruct.new(id: 5)
=> #<OpenStruct id=5>

> client = Unleash::Incognia::Client.new(user: user, organization: organization)
=> #<Unleash::Incognia::Client:0x000055caf7c7f390 @user=#<OpenStruct id=2, email="my@mail.com">, @organization=#<OpenStruct id=5>>

# List enabled features
> client.enabled_features
=> ["incognia_feature_1", "incognia_feature_2", "incognia_feature_3"]

# Ask if some feature is enabled
> client.feature_enabled?("disabled_feature")
=> false

> client.feature_enabled?("incognia_feature_2")
=> true
```

### Configuration

Whenever you have `Unleash::Client` being instanciated change it to:

```ruby
Unleash::Incognia.configure do |config|
  config.unleash_client = Unleash::Client.new
end
```

Or:

```ruby
Unleash::Incognia.configuration.unleash_client = Unleash::Client.new
```

This way, `Unleash::Incognia` client will use proper `Unleash` client.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/unleash-incognia.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
