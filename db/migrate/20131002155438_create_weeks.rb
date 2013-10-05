class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.integer :week_no
      t.integer :season_id

      t.timestamps
    end
  end
end
