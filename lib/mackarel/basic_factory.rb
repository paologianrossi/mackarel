module Mackarel::BasicFactory
  extend self

  def create(what, fields=nil, _=nil)
    object = what.new(*fields)
    yield(object) if block_given?
    object
  end

  def create_list(what, number=1, fields=nil, _nil)
    object = []
    number.times { object << what.new(*fields) }
    yield(object) if block_given?
    object
  end
end
