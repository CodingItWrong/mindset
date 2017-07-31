class CreatePrayers < ActiveRecord::Migration[5.1]
  def change
    create_table :prayers do |t|
      t.text :text
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
