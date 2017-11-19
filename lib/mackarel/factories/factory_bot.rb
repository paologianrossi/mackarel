require "factory_bot"

module Mackarel::FactoryBot
  extend self

  def create(what, options)
    FactoryBot.create(what, options)
  end

  def create_list(what, number, options)
    FactoryBot.create_list(what, number, options)
  end
end
