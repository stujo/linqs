class Tag < ActiveRecord::Base
  belongs_to :user
  has_many :link_tags
  has_many :links, through: :link_tags
end
