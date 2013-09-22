class CreateMaterial < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.string :name
      t.text :description
      t.boolean :featured

      t.string :type

      t.timestamps
    end
  end
end
