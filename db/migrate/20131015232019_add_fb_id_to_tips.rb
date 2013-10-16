class AddFbIdToTips < ActiveRecord::Migration
  def change
    add_column :tips, :fb_id, :integer, { :null => true, :limit => 24 }
  end
end
