class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name
  # attr_accessible :title, :body

  has_many :libraries
  has_many :poems

  validates :first_name, presence: true

  before_create :set_password

  def set_password
    self.password = Devise.friendly_token.first(8)
  end

  def full_name
    first_name + " " + last_name
  end
end
