class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.text :content, null: false
      t.string :star

      t.timestamps
    end
  end
end
