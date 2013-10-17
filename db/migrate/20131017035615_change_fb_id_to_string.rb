class ChangeFbIdToString < ActiveRecord::Migration
  def change
    change_column :tips, :fb_id, :string
  end
end
