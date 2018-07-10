# ProcessChain
[![Build Status](https://travis-ci.org/max-konin/process_chain.svg?branch=master)](https://travis-ci.org/max-konin/process_chain)
[![Coverage Status](https://coveralls.io/repos/github/max-konin/process_chain/badge.svg?branch=master)](https://coveralls.io/github/max-konin/process_chain?branch=master)
[![Inline docs](http://inch-ci.org/github/max-konin/process_chain.svg?branch=master)](http://inch-ci.org/github/max-konin/process_chain)


ProcessChain gives you a simple way to using the Railsway oriented programming pattern. And allows you to write code in a more functional style.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'process_chain'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install process_chain

## Usage


```ruby
class UpdateUserProcess
  include ProcessChain

  def assignee_attributes(attrs)
    if_success do
    return_success user: results.user.assigne_attributes(attrs)
    end
  end

  def validate_user
    if_success do
      if results.user.valid?
        return_fail errors: results.user.errors, user: results.user
      else
        return_success
      end
    end
  end

  def save_user
    user = results.user
    if_success do
      if user.save
        return_success user: user
      else
        return_fail user: results.user
      end
    end
  end
end

## Controller
def create
  process = UpdateUserProcess.new(input: user)
                             .assignee_attributes(permitted_params)
                             .validate_user
                             .save_user
  if process.success?
    render status: :ok, json: process.results.user
  else
    render status: :bad_request, json: process.results.errors
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/max-konin/process_chain. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ProcessChain project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/max-konin/process_chain/blob/master/CODE_OF_CONDUCT.md).
