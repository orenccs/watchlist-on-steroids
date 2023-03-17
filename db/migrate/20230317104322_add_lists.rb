class AddLists < ActiveRecord::Migration[7.0]
  create_table "lists" do |t|
    t.string "name"
    t.timestamps
  end
  create_table "bookmarks" do |t|
    t.text "comment"
    t.references :movie, foreign_key:true
    t.references :list, foreign_key:true
    t.timestamps
  end
  create_table "reviews" do |t|
    t.text "comment"
    t.integer "rating"
    t.references :list, foreign_key: true
    t.timestamps
  end
end
