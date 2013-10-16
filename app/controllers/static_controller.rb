class StaticController < ApplicationController
  def index
    @title = "BBB"

    # material_subclasses = Material.descendants
    material_subclasses = [Kernel.const_get(:Salt), Kernel.const_get(:Oil)]
    @material_subclass_featured = {}
    material_subclasses.each do |sc|
      @material_subclass_featured[sc.name] = sc.where(featured: true).limit(4).shuffle
    end
  end
end

=begin
  
  1: get a list of subclasses
  2: each of those subclasses needs to bring with itself its 
    Class name (for link)
    4 featured examples
  3: send these to a partial
  4: all the partials are rendered on the index page
  
=end

