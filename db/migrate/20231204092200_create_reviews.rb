class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :line_plan, null: false, foreign_key: true
      t.text :content, null: false
      t.string :star

      t.timestamps
    end
  end
end
