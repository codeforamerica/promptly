class User < ActiveRecord::Base

  require 'role_model'
  include RoleModel

  has_many :organizations_user
  has_many :organizations, through: :organizations_user

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :current_password
  attr_accessible :email, :password, :password_confirmation, :remember_me, :roles, :roles_mask, :name, :id, :reset_password_token, :current_password
  validates_presence_of :email

  # optionally set the integer attribute to store the roles in,
  # :roles_mask is the default
  roles_attribute :roles_mask

  # declare the valid roles -- do not change the order if you add more
  # roles later, always append them at the end!
  roles :super, :user

end
