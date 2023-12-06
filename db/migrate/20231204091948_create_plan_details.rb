class CreatePlanDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :plan_details do |t|
      # t.references :line_plan, null: false, foreign_key: true
      t.string :plan_code, null: false
      t.string :plan_text, null: false

      t.timestamps
    end
  end
end
