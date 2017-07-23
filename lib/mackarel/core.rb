module Mackarel
  module Core
    def when_i
      yield
    end

    def when_there_exists_a(factory, overrides={})
      called = overrides.delete(:called) || factory
      instance_variable_set("@#{called}", FactoryGirl.create(factory, overrides))
    end

    def when_there_exist(number, factory, overrides={})
      called = overrides.delete(:called) || factory
      instance_variable_set("@#{called}", FactoryGirl.create_list(factory, number, overrides))
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
