class AddAnswerToPrayers < ActiveRecord::Migration[5.1]
  def change
    add_column :prayers, :answer, :string
  end
end
