# frozen_string_literal: true

class Memo
  attr_accessor :id, :title, :content

  def initialize(id, title, content)
    @id = id
    @title = title
    @content = content
  end
end
