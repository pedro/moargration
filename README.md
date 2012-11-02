# Moargration

Helping you migrate, MOAR.

This is Ruby gem that takes environment variables to assist the execution of database migrations that would otherwise require two-step deploys.

For more information refer to [Rails migrations with no downtime](http://pedro.herokuapp.com/past/2011/7/13/rails_migrations_with_no_downtime/).


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

Knowing that this can bring your app down, and that you normally need to do two deploys to safely dro pcolumns, you can use Moargration to setup the first step for you.

Just set an `ENV` var like:

    MOARGRATION_IGNORE="users:notes,bio companies:another_stupid_column"

And bounce your servers. Moargration will make sure that once the servers are running again your ORM will be ignoring these columns so that you can safely run the migration to drop them.

After the migration finishes you can unset that variable and enjoy your new database schema.


## The example above is not completely obvious, I need a [BNF grammar](http://en.wikipedia.org/wiki/Backus%E2%80%93Naur_Form)

Sure thing, bro:

    <ignore>     ::= <definition> { " " <definition> }
    <definition> ::= <table> ":" <fields>
    <fields>     ::= <field> { "," <field> }


## Notes

Created by Pedro Belo.
Licensed as MIT.
Use at your own risk.