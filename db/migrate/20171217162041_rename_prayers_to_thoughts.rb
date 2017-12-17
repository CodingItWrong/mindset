class RenamePrayersToThoughts < ActiveRecord::Migration[5.1]
  def up
    rename_table :prayers, :thoughts
    conn.execute("UPDATE taggings SET taggable_type = 'Thought' WHERE taggable_type = 'Prayer'")
  end

  def down
    conn.execute("UPDATE taggings SET taggable_type = 'Prayer' WHERE taggable_type = 'Thought'")
    rename_table :thoughts, :prayers
  end

  private

  def conn
    ActiveRecord::Base.connection
  end
end
