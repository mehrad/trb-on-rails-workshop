class CreateCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :countries do |t|
      t.string :name, :unique => true
      t.string :iso_code, :unique => true
      t.multi_polygon :geom, :srid => 4326
      t.timestamps
    end

    change_table :countries do |t|
      t.index :geom, using: :gist
    end
  end
end
