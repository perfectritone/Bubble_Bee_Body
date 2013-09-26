class MoveMaterialsOutOfSti < ActiveRecord::Migration
  def up

    # Create a hash with each inheriting type as the key and an
    # array of objects of that type for the value.
    materials = {}
    Material.all.each do |material|
      type = material.type
      if materials.has_key?(type)
        materials[type] << material
      else
        materials[type] = [material]
      end
    end

    materials.each do |type, objects_of_type|
      # Create new tables for the types.
      table_name = type.tableize.to_sym

      create_table table_name do |t|
        t.string :name
        t.text :description
        t.boolean :featured

        t.timestamps
      end

      # Get the class name.
      type_class = Object.const_set(type, Class.new(ActiveRecord::Base))
      type_class.reset_column_information

      # Load the data into these tables.
      objects_of_type.each do |object|
        type_class.create!(
          name: object.name,
          description: object.description,
          featured: object.featured,
          created_at: object.created_at,
          updated_at: object.updated_at
        )
      end
    end
  end

  def down
    # This is not implemented since it should not be necessary.
    # When it was run, the two materials were Salts and Oils.
    raise NoMethodError
  end
end