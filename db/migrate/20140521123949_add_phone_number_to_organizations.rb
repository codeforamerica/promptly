class AddPhoneNumberToOrganizations < ActiveRecord::Migration
  def change
    add_column :organizations,  :phone_number, :string
  end
end
