class CreateAreaLines < ActiveRecord::Migration[6.1]
  def change
    create_table :area_lines do |t|
      t.references :area, null: false, foreign_key: true
      t.references :line_plan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
