class ImportCountriesFromShp < ActiveRecord::Migration[5.2]
  def up
    from_shp_sql = `shp2pgsql -c -g geom -W LATIN1 -s 4326 #{Rails.root.join('db', 'shpfiles', 'gadm36_IRN_1')} countries_ref`

    Country.transaction do
      execute <<-SQL
          drop table if exists countries_ref
      SQL

      execute from_shp_sql

      execute <<-SQL
          insert into countries(name, geom, created_at, updated_at)
            select name_1, geom, current_timestamp, current_timestamp from countries_ref
      SQL

      drop_table :countries_ref
    end

  end

  def down
    Country.delete_all
  end

end