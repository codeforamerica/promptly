class ChangePhoneFieldtoString < ActiveRecord::Migration
  def up
  	change_column :recipients, :phone, :string
  end

  def down
  end
end
