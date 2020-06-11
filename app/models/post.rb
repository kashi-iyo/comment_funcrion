class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  has_many :post_tag_maps, dependent: :destroy
  has_many :post_tags, through: :post_tag_maps, dependent: :destroy

  def save_tag(sent_tags)
    current_tags = self.post_tags.pluck(:post_tag_name) unless self.post_tags.nil?
    old_tags = current_tags - sent_tags
    new_tags = sent_tags - current_tags

    old_tags.each do |old|
      self.post_tags.delete PostTag.find_by(post_tag_name: old)
    end

    new_tags.each do |new|
      new_post_tag = PostTag.find_or_create_by(post_tag_name: new)
      self.post_tags << new_post_tag
    end
  end
end
