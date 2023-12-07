class CreateContentLines < ActiveRecord::Migration[6.1]
  def change
    create_table :content_lines do |t|
      t.references :content, null: false, foreign_key: true
      t.references :line_plan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
