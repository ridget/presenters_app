class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.string :name
      t.references :user
      t.timestamps
    end
  end
end
