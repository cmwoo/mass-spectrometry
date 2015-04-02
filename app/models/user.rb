class User < ActiveRecord::Base
  has_many :mass_data, :dependent => :destroy
  has_many :mass_params, :dependent => :destroy
  has_many :results, :dependent => :destroy
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
end
