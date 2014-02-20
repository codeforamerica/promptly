class OrganizationsUser < ActiveRecord::Base

  attr_accessible :organization_id, :user_id, :roles_mask

	require 'role_model'
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable


	include RoleModel
  # Setup accessible (or protected) attributes for your model
  attr_accessible :organization_id, :user_id, :roles, :roles_mask, :name
  # attr_accessible :title, :body

  validates_presence_of :organization_id, :user_id
  validates_uniqueness_of :organization_id, :user_id

  # optionally set the integer attribute to store the roles in,
  # :roles_mask is the default
  roles_attribute :roles_mask

  # declare the valid roles -- do not change the order if you add more
  # roles later, always append them at the end!
  roles :admin, :user, :guest

end
