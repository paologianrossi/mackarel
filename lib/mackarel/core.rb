module Mackarel
  module Core
    def when_i
      yield
    end

    def when_there_exists_a(factory, overrides={})
      called = overrides.delete(:called) || factory
      asset = FactoryGirl.create(factory, overrides)
      instance_variable_set("@#{called}", asset)
      yield(asset) if block_given?
    end

    def when_there_exist(number, factory, overrides={})
      called = overrides.delete(:called)
      asset = FactoryGirl.create_list(factory, number, overrides)
      if called
        instance_variable_set("@#{called}", asset)
      else
        instance_variable_set("@#{factory}", asset)
        instance_variable_set("@#{factory}_list", asset)
      end

      yield(asset) if block_given?
    end

    alias and_i when_i
    alias and_also when_i
    alias given when_i

    alias when_there_exists_an when_there_exists_a
    alias and_there_exists_a when_there_exists_a
    alias and_there_exists_an when_there_exists_a

    alias and_there_exist when_there_exist

  end
end
