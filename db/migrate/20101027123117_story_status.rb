class StoryStatus < ActiveRecord::Migration
  def self.up
    create_table :story_statuses do |t|
      t.string :title, :null => false
      t.timestamp :create_date

      t.timestamps
    end
    add_column :stories, :story_status_id, :integer, :null => false, :default => 1
  end

  def self.down
    drop_table :story_statuses
    remove_column :stories, :story_status_id
  end
end
