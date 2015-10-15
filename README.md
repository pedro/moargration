# Moargration

Helping you migrate MOAR.

Moargration helps you drop columns without downtime. Without it, ActiveRecord keeps columns cached and freaks out when they're gone.

To better understand the problem consider this timeline:

- Unicorn server boots up, ActiveRecord caches columns in the database
- Someone runs `rake db:migrate` and drops a column
- Unicorn starts raising errors when controllers try to call create/update/find on the corresponding model, issuing queries that have the removed column

With Moargration you can tell ActiveRecord to ignore certain columns from the cache, so that they can be removed safely.

For more information refer to [Rails migrations with no downtime](http://pedro.herokuapp.com/past/2011/7/13/rails_migrations_with_no_downtime/).


## Compatibility

Works with ActiveRecord 2, 3 and 4.

Cached columns are a big problem in AR2 because they're written with all `INSERT` and `UPDATE`.

Starting in version 3 AR only uses columns that have a value set when writing `INSERT`, and uses the dirty attribute check to figure out which columns to `UPDATE`, so you won't run into issues creating or updating records. BUT finders with joins will still rely on cached columns to build a query, so these might still raise database errors.

This doesn't work with Sequel atm. Similar to AR3+ it doesn't use cached columns on `INSERT`, but calling `.save` on a model does so it will raise on removed columns too.


## Setup

Add to your Gemfile:

```ruby
gem "moargration"
```

Then initialize it from an initializer, eg `config/initializers/moargration.rb` for Rails apps:

```ruby
Moargration.init
```

Worry not, Moargration won't impact your boot time until you actually need it.


## Usage

So it's time to drop some columns.

Knowing that this can bring your app down, and that you normally need to do two deploys to safely drop columns, you can use Moargration to setup the first step for you.

Just set an `ENV` var like:

    MOARGRATION_IGNORE="users:notes,bio companies:another_stupid_column"

And bounce your servers. Moargration will make sure that once the servers are running again your ORM will be ignoring these columns so that you can safely run the migration to drop them.

After the migration finishes you can unset that variable and enjoy your new database schema.


## The example above is not completely obvious, I need a [BNF grammar](http://en.wikipedia.org/wiki/Backus%E2%80%93Naur_Form)

Sure thing:

    <ignore>     ::= <definition> { " " <definition> }
    <definition> ::= <table> ":" <fields>
    <fields>     ::= <field> { "," <field> }


## Todo

* Sequel::Model support


## Notes

Created by Pedro Belo.
Licensed as MIT.
Use at your own risk.
