class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :time
      t.string :description
      t.string :venue

      t.timestamps null: false
    end
  end
end
