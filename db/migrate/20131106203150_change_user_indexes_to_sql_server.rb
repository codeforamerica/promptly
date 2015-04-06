class ChangeUserIndexesToSqlServer < ActiveRecord::Migration
  def up
    if ActiveRecord::Base.connection.adapter_name == "sqlserver"
      # fixing https://github.com/rails-sqlserver/activerecord-sqlserver-adapter/issues/153
      remove_index :users, :email
      remove_index :users, :reset_password_token
      execute "CREATE UNIQUE NONCLUSTERED INDEX index_users_on_reset_password_token ON users (reset_password_token) WHERE reset_password_token IS NOT NULL;"
      execute "CREATE UNIQUE NONCLUSTERED INDEX index_users_on_email ON .users (email) WHERE email IS NOT NULL;"
    end
  end

  def down
    if ActiveRecord::Base.connection.adapter_name == "sqlserver"
      execute "DROP INDEX index_users_on_reset_password_token ON users;"
      execute "DROP INDEX index_users_on_email ON users;"
      add_index :users, :email, name: 'index_users_on_email', unique: true
      add_index :users, :reset_password_token, name: 'index_users_on_reset_password_token', unique: true
    end
  end
end
