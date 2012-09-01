class Library < ActiveRecord::Base
  belongs_to :creator, foreign_key: :user_id, class_name: "User"
  has_many :readings, dependent: :destroy
  attr_accessible :description, :name

  validates :name, :description, presence: true
end
