class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.references :era, null: false, foreign_key: true
      t.references :event_type, null: false, foreign_key: true
      t.integer :date_yyyy
      t.integer :date_mm
      t.integer :date_dd
      t.text :date_display
      t.text :title
      t.text :text
      t.string :link
      t.references :source, foreign_key: true

      t.timestamps
    end
  end
end
