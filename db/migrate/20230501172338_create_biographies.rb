class CreateBiographies < ActiveRecord::Migration[7.0]
  def change
    create_table :biographies do |t|
      t.references :biography_type, null: false, foreign_key: true
      t.text :title
      t.text :subtitle
      t.text :text
      t.text :info
      t.integer :date_yyyy
      t.integer :date_mm
      t.integer :date_dd
      t.float :display_order, default: 0.0

      t.timestamps
    end
  end
end
