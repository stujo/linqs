class CreateLinkTags < ActiveRecord::Migration
  def change
    create_table :link_tags do |t|
      t.references :link, index: true
      t.references :tag, index: true

      t.timestamps
    end
  end
end
