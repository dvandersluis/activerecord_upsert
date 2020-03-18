# ActiveRecord Upsert

[![Build Status](https://travis-ci.org/dvandersluis/activerecord_upsert.svg?branch=master)](https://travis-ci.org/dvandersluis/activerecord_upsert)
[![Gem Version](https://badge.fury.io/rb/activerecord_upsert.svg)](https://badge.fury.io/rb/activerecord_upsert)

Adds the ability to use MySQL's `ON DUPLICATE KEY UPDATE` with arbitrary values in order to upsert records in ActiveRecord.

Supports Rails 5.2 and 6, and should not conflict with Rails 6's `Model.upsert` or `Model.upsert_all`, because this gem adds `upsert` to `ActiveRecord::Relation`.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'activerecord_upsert'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install activerecord_upsert

## Usage

```ruby
Model.where(foo: :bar).upsert(count: 'count + 1')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/activerecord_upsert.
