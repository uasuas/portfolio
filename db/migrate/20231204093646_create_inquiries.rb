class CreateInquiries < ActiveRecord::Migration[6.1]
  def change
    create_table :inquiries do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.text :content, null: false
      t.boolean :status, null: false, default: false

      t.timestamps
    end
  end
end
