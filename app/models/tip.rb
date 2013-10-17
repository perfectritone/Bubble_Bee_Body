class Tip < ActiveRecord::Base
  validates_presence_of :title, :content

  def to_s
    <<-STRING
#{self.title}

#{self.content}
    STRING
  end
end