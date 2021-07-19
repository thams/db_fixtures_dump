# db:fixtures:dump

Adds db:fixtures:dump rake task to dump all ActiveRecord tables into yaml fixtures

May not work for tables with serialized columns.

## Installation

Add this line to your application's Gemfile:

    gem 'db_fixtures_dump'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install db_fixtures_dump

## Usage

    $ rake db:fixtures:dump

### Output directory

Just like for the db:fixtures:load , you may specify FIXTURES_PATH to be used as the output directory.

    $ FIXTURES_PATH=db/backup rake db:fixtures:dump

### Excluding models

You can exclude models by specifying a list as EXCLUDE_MODELS.

	$ EXCLUDE_MODELS="MyLegacyModel AnotherOne" rake db:fixtures:dump

Or in combination with FIXTURES_PATH,

	$ EXCLUDE_MODELS="MyLegacyModel AnotherOne" FIXTURES_PATH=test/fixtures rake db:fixtures:dump


### Including only some models

You can include only some models by specifying a list as INCLUDE_MODELS.

  $ INCLUDE_MODELS="MyLegacyModel AnotherOne" rake db:fixtures:dump

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## References

Original gists:

* http://snippets.dzone.com/posts/show/4468 by Michael Boutros
* https://gist.github.com/iiska/1527911


Making a rake task into a gem:

* http://blog.nathanhumbert.com/2010/02/rails-3-loading-rake-tasks-from-gem.html
