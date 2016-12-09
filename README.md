# Mackarel

Mackarel is a small, hacky extension for acceptance testing in Rails with Capybara and FactoryGirl.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mackarel', group: :test
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mackarel

In your spec/spec_helper.rb file add

```ruby
config.include Mackarel
```

## Usage

Mackarel allows you to write acceptance tests in Rails in a readable way without having to deal with things like Cucumber. It uses feature tests with RSpec, Factorygirl as the factory for models, and generally follows my setup.

You can do things like:

```ruby
RSpec.feature "Visiting the homepage" do

  scenario "'Logo' as a header" do
    when_i { visit root_path }

    # There is an image on the page, with the alt_text of "Logo"
    i_find_an :image, with_text: "Logo"
  end

  scenario "I find a Log in button" do
    when_i { visit root_path }
    and_i { click_on I18n.t("devise.sign_in") }

    i_am_taken_to_the new_user_session_path
  end

end
```

### TODO: Document all helpers

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/paologianrossi/mackarel. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
