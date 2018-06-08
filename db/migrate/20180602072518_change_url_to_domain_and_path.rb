class ChangeUrlToDomainAndPath < ActiveRecord::Migration[5.2]
  def change
    rename_column :visits, :url, :domain
    add_column :visits, :path, :string
  end
end
