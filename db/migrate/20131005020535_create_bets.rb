class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.integer :team_id
      t.integer :week_id
      t.integer :user_id

      t.timestamps
    end
  end
end
