class CreateStories < ActiveRecord::Migration
  def self.up
    create_table :stories do |t|
      t.string :title
      t.text :description
      t.integer :estimate
      t.timestamp :create_date

      t.timestamps
    end
  end

  def self.down
    drop_table :stories
  end
end
