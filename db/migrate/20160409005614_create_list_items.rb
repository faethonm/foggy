class CreateListItems < ActiveRecord::Migration
  def change
    create_table :list_items do |t|
      t.string :name
      t.references :list, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
