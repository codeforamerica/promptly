class User < ActiveRecord::Base
  has_and_belongs_to_many :organizations

	require 'role_model'
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

	include RoleModel
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :roles, :roles_mask, :name, :id
  # attr_accessible :title, :body

  validates_presence_of :email


end
