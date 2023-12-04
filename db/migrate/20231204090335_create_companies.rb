class CreateCompanies < ActiveRecord::Migration[6.1]
  def change
    create_table :companies do |t|
      t.string :name, null: false
      t.string :zip_code, null: false
      t.string :address, null: false
      t.string :telephone_number, null: false

      t.timestamps
    end
  end
end
