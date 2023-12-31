class CreateLinePlans < ActiveRecord::Migration[6.1]
  def change
    create_table :line_plans do |t|
      t.references :company, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :monthly_fee, null: false
      t.text :introduction, null: false

      t.timestamps
    end
  end
end
