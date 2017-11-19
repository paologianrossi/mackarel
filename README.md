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

In your `spec/spec_helper.rb` or `spec/rails_helper.rb` file add:

```ruby
RSpec.configure { |c| config.include Mackarel }
```

If you want to use [FactoryGirl](https://github.com/thoughtbot/factory_girl) as the backend for creating assets, add also:

```ruby
Mackarel.config { |c| c.factory = FactoryGirl }
```

## Usage

Mackarel allows you to write acceptance tests in Rails in a readable way without having to deal with things like Cucumber.

It uses feature tests with RSpec. It can use Factorygirl as the factory for models, and Capybara for website testing.

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

### What are all the things I can do?

#### Yielding

```ruby
given {}
when_i {}
and_also {}
and_i {}
then_i {}
```

These just yield. They are used to increase readibility:

```ruby
RSpec.feature "Visiting admin page" do
    scenario "It authenticates" do
        given { username = "user" }
        and_also { pass = "pass" }

        when_i { visit admin_page_path }
        and_i { login_with(username, pass) }

        then_i { expect(page).to have_http_status(200) }
    end
end
```

#### Create objects

```ruby
create(what, *args, **kwargs, &blk)
when_there_exists_a(what, *args, **kwargs, &blk)
when_there_exists_an(what, *args, **kwargs, &blk)
and_there_exists_a(what, *args, **kwargs, &blk)
and_there_exists_an(what, *args, **kwargs, &blk)
```

These generate objects. By default, they use `Mackarel::BasicFactory`
to do so, but you can change that to use Factorygirl with
`Mackarel.config.factory = Mackarel::FactoryGirl`, or create your own. See later in this README to see how.


Create and friends figure out what you want to call the created
object: by default, it uses the "what", by converting it to a string,
downcasing it, and "underscore-ing" it. Also, l You can pass option
`called:` to change that name. They also return the created object. If
you pass `called: nil`, they don't create any instance variable.

The `what`, `*args` and `*kwargs` are passed as is to the factory.

For example:
```
RSpec.feature "Visiting widget page" do
    scenario "lists all widgets" do
        when_i { create Widget, name: "first" }
        and_there_exist_a Widget, name: "second"

        and_i { visit admin_page_path }

        then_i { can_see "first" }
        and_i { can_see "second" }
    end
end
```

#### Create lists
```ruby
create_a_list_of(n, what, *args, **kwargs, &blk)
and_there_exist(n, what, *args, **kwargs, &blk)
when_there_exist(n, what, *args, **kwargs, &blk)
```

You can also generate lists of objects with one call. To do that, use `create_a_list_of` or one of its aliases. Pass how many objects you want in the list as the first parameter:

```
RSpec.feature "Visiting widget page" do
    scenario "lists all widgets" do
        when_there_exist 5,  Widget, name: "widget"
        and_i { visit admin_page_path }

        i_find ".widget", count: 5
    end
end
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/paologianrossi/mackarel. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
