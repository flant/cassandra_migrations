Cassandra Migrations
====================

_There has not yet been a stable release of this project._

**Warning: this README does not apply to the current release (0.0.1.pre4), since the release is outdated. Wait few more days!**

# Requirements

- Cassandra 1.2 or higher with the native_transport_protocol turned on
- Ruby 1.9
- Rails 3.2

# Installation

    gem install --prerelease cassandra_migrations

# Quick start

### Configure Cassandra

The native transport protocol (sometimes called binary protocol, or CQL protocol) is not on by default in Cassandra 1.2, to enable it edit the `CASSANDRA_DIR/conf/cassandra.yaml` file on all nodes in your cluster and set `start_native_transport` to `true`. You need to restart the nodes for this to have effect.

### Prepare Project

In your rails root directory:

    prepare_for_cassandra .
    
### Configuring Cassandra Access

Open your newly-created `config/cassandra.yml` and configure the database name for each of the environments, just like you would do for your regular database. The other options defaults should be enough for now.

```ruby
development:
  host: '127.0.0.1'
  port: 9042
  keyspace: 'my_keyspace_name'
  replication:
    class: 'SimpleStrategy'
    replication_factor: 1
```

### Create your database

There are a collection of rake tasks to help you manage the cassandra database (`rake cassandra:create`, `rake cassandra:migrate`, `rake cassandra:drop`, etc.). For now this one does the trick:

    rake cassandra:setup

### Create a test table

    rails generate cassandra_migration create_posts
    
In your migration file, make it create a table and drop it on its way back:

```ruby
class CreatePosts < CassandraMigrations::Migration
  def up
    create_table :posts do |p|
      p.integer :id, :primary_key => true
      p.timestamp :created_at
      p.string :title
      p.text :text
    end
  end
  
  def self.down
    drop_table :posts
  end
end
```
... to be continued
