class NovelTagMap < ApplicationRecord
  belongs_to :novel
  belongs_to :novel_tag
end
