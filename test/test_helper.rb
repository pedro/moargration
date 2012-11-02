require "minitest/spec"
require "minitest/autorun"
require "active_record"
require "./lib/moargration"
require "uri"

ActiveRecord::Base.establish_connection({
  :adapter  => "postgresql",
  :host     => "localhost",
  :database => "moargration_test",
  :min_messages => "warning"
})
ActiveRecord::Base.connection.execute "DROP TABLE IF EXISTS samples"
ActiveRecord::Base.connection.execute "CREATE TABLE samples ( id integer UNIQUE, f1 text, f2 text, f3 text)"
ActiveRecord::Base.connection.execute "DROP TABLE IF EXISTS users"
ActiveRecord::Base.connection.execute "CREATE TABLE users ( id integer UNIQUE, f1 text, f2 text, f3 text)"

class Sample < ActiveRecord::Base
end

class User < ActiveRecord::Base
end