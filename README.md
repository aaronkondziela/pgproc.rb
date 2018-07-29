# Pgproc

Automagically creates methods for all database functions within a schema. Makes life grand.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pgproc'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pgproc

## Usage

	irb(main):001:0> require_relative "pgproc"
	=> true

	irb(main):002:0> pg = Pg::Proc.new dbname: "ev"
	=> #<Pg::Proc:0x00000001f3acb8 @pg=#<PG::Connection:0x00000001f3aba0>>

	irb(main):003:0> res = pg.func_returning_one_thing()
	=> "42"

	irb(main):004:0> res = pg.func_returning_set_of_records()
	=> #<PG::Result:0x00000001f123d0 status=PGRES_TUPLES_OK ntuples=2 nfields=6 cmd_tuples=2>

	irb(main):005:0> res[0]
	=> {"id"=>"123", "data"=>"foo"}

	irb(main):006:0> res[0]['id']
	=> "123"

	irb(main):007:0> res.each { |row| puts row['id'] }
	123
	456
	=> #<PG::Result:0x00000001f123d0 status=PGRES_TUPLES_OK ntuples=2 nfields=6 cmd_tuples=2>

	irb(main):008:0> res = pg.func_adding_up_args(20, 12, 10)
	=> "42"

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/aaronkondziela/pgproc.rb

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT). See LICENSE.txt for details.

