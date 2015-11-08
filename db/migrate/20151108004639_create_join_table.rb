class CreateJoinTable < ActiveRecord::Migration
  def change
    create_join_table :repos, :words do |t|
      t.index [:repo_id, :word_id]
      t.index [:word_id, :repo_id]
    end
  end
end
