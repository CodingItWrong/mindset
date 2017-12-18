class RenameAnswerToResolutionOnThoughts < ActiveRecord::Migration[5.1]
  def change
    rename_column :thoughts, :answer, :resolution
  end
end
