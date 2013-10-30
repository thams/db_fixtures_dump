require 'db_fixtures_dump'
require 'rails'
module DBFixturesDump
  class Railtie < Rails::Railtie
    railtie_name :db_fixtures_dump

    rake_tasks do
      load "tasks/db_fixtures_dump.rake"
    end
  end
end