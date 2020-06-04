class CreateNovelTags < ActiveRecord::Migration[5.2]
  def change
    create_table :novel_tags do |t|
      t.string :novel_tag_name

      t.timestamps
    end
  end
end
