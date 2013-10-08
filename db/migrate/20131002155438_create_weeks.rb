class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.integer :week_no
      t.integer :season_id
      t.string :progress

      t.timestamps
    end
  end
end
