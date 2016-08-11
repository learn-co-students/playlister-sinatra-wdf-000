require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

require_relative 'app/controllers/application_controller'
require_relative 'app/controllers/artists_controller'

use Rack::MethodOverride
use GenresController
use ArtistsController
use SongsController
run ApplicationController