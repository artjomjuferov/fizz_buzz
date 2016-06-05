class CreateFavorites < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.bigint :number

      t.timestamps null: false
    end
  end
end
