class User < ActiveRecord::Base
  # validates :name, :login, :email, :presence => true
  # validates :email, :confirmation => true
  # validates :email_confirmation, :presence => true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
