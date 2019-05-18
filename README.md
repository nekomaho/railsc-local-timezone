# Rails Local DB Time
rails local db time is a gem that makes the display of Date and Time in railc localized.

On railsc, the UTC value is displayed by default when displaying the database Date and Time. This gem changes the Date and Time display to a localized version set by `config.time_zone`.

For example, a rails application localized setting blow.
```
config.time_zone = 'Tokyo'
```

The output changes as follows before and after using this gem.

- before
```ruby
irb(main):001:0> User.first
  User Load (0.1ms)  SELECT  "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT ?  [["LIMIT", 1]]
=> #<User id: 1, created_at: "2018-09-16 05:59:17 UTC", updated_at: "2018-09-16 05:59:17 UTC">
```

- after
```ruby
irb(main):001:0> User.first
  User Load (0.1ms)  SELECT  "users".* FROM "users" ORDER BY "users"."id" ASC LIMIT ?  [["LIMIT", 1]]
=> #<User id: 1, created_at: "2018-09-16 23:59:17 +0900", updated_at: "2018-09-16 23:59:17 +0900">
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'railsc-local-db-time'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install railsc-local-db-time

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/railsc-local-db-time. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Railsc::Local::Db::Time project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/railsc-local-db-time/blob/master/CODE_OF_CONDUCT.md).
