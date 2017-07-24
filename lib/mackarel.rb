require "mackarel/version"
require "mackarel/config"

require "mackarel/core"
require "mackarel/capybara"

require "mackarel/factories"

module Mackarel
  include Core
  include Capybara

  def self.config(&blk)
    if blk
      Config.config(&blk)
    else
      Config
    end
  end
end
