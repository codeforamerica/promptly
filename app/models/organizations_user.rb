class OrganizationsUser < ActiveRecord::Base
  require 'role_model'
  require 'composite_primary_keys'
  include RoleModel

  attr_accessible :organization_id, :user_id, :roles_mask, :roles, :name
  validates_presence_of :organization_id, :user_id, :roles_mask
  validates :roles_mask, numericality: { greater_than: 0 }
  self.primary_keys = :organization_id, :user_id
  belongs_to :organization
  belongs_to :user

  # optionally set the integer attribute to store the roles in,
  # :roles_mask is the default
  roles_attribute :roles_mask

  # declare the valid roles -- do not change the order if you add more
  # roles later, always append them at the end!
  roles :admin, :user, :guest

  scope :org_user, ->(org_id, user_id) { where("organization_id = ? and user_id=?", org_id, user_id) }

end
