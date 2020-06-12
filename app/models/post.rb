class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  has_many :post_tag_maps, dependent: :destroy
  has_many :post_tags, through: :post_tag_maps, dependent: :destroy

  # 新規投稿の際は単純に新しいタグが保存れ、編集の際は古いタグが除外され新しいタグが保存される。
  def save_tag(sent_tags)
    #そのPostに紐付いているタグが存在する場合、「タグ名の配列として」全て取得
    current_tags = self.post_tags.pluck(:post_tag_name) unless self.post_tags.nil?
    #現在存在するタグから、送信されてきたタグを除いたタグをold_tagsとする。
    old_tags = current_tags - sent_tags
    #送信されてきたタグから、現在存在するタグを除いたタグをnew_tagsとする。
    new_tags = sent_tags - current_tags

    #old_tags内のタグを削除する
    old_tags.each do |old|
      self.post_tags.delete PostTag.find_by(post_tag_name: old)
    end

    #送信されてきたタグのみを、posts_tagsテーブルに新たに保存する
    new_tags.each do |new|
      new_post_tag = PostTag.find_or_create_by(post_tag_name: new)
      self.post_tags << new_post_tag
    end
  end
end
