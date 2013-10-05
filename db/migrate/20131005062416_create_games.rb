class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :home_team_id
      t.integer :away_team_id
      t.integer :week_id
      t.string :home_team_outcome
      t.string :progress

      t.timestamps
    end
  end
end
