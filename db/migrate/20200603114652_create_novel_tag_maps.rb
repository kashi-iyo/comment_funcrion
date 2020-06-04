class CreateNovelTagMaps < ActiveRecord::Migration[5.2]
  def change
    create_table :novel_tag_maps do |t|
      t.references :novel, presence: true, foreign_key: true
      t.references :novel_tag, presence: true,  foreign_key: true

      t.timestamps
    end
  end
end
