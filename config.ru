require_relative './config/environment'
require './config/environment'

# if ActiveRecord::Migration.needs_migration?
#   raise 'Migrations are pending. Run `rake db:migrate` to resolve this issue.'
# end

use Rack::MethodOverride
run ApplicationController
use EventsController
use UsersController
