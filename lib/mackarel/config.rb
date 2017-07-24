module Mackarel::Config
  extend self

  attr_writer :factory

  def factory
    @factory ||= Mackarel::BasicFactory
  end

  def config(&blk)
    instance_eval(&blk)
  end
end
