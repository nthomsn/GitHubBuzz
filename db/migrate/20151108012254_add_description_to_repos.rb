class AddDescriptionToRepos < ActiveRecord::Migration
  def change
    add_column :repos, :description, :string
  end
end
