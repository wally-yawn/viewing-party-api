class CreateViewingParty < ActiveRecord::Migration[7.1]
  def change
    create_table :viewing_parties do |t|
      t.integer :host
      t.string :name
      t.string :start_time
      t.string :end_time
      t.integer :movie_id
      t.string :movie_title

      t.timestamps
    end
  end
end
