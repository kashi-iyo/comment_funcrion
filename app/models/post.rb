class Post < ApplicationRecord
  belongs_to :user
  has_many :comments

  has_many :post_tag_maps, dependent: :destroy
  has_many :post_tags, through: :post_tag_maps
end
