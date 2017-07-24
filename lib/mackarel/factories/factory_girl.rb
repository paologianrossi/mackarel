require "factory_girl"

module Mackarel::FactoryGirl
  extend self

  def create(what, options)
    FactoryGirl.create(what, options)
  end

  def create_list(what, number, options)
    FactoryGirl.create_list(what, number, options)
  end
end
