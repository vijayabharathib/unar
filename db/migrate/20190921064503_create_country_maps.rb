class CreateCountryMaps < ActiveRecord::Migration[6.0]
  def change
    create_table :country_maps do |t|
      t.string :ip
      t.string :country

      t.timestamps
    end
    add_index :country_maps, :ip
  end
end
