require './config/environment'

if ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending. Run `rake db:migrate` to resolve the issue.'
end

# Mount Controllers
use Rack::MethodOverride
use ArtistsController
use SongsController
use GenresController
run ApplicationController
