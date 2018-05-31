class CreateVisits < ActiveRecord::Migration[5.2]
  def change
    create_table :visits do |t|
      t.string :url
      t.string :ip
      t.string :device
      t.string :country
      t.string :referer
      t.string :keyword
      t.boolean :bounce
      t.integer :retention
      t.string :browser
      t.string :version

      t.timestamps
    end
  end
end
