class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :omniauthable, :trackable, :validatable

  validates_presence_of :provider
  validates_presence_of :uid
end
