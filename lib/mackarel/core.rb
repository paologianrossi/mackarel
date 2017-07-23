module Mackarel
  module Core
    def when_i
      yield
    end

    def factory
      Mackarel.config.factory
    end

    def when_there_exists_a(what, *args, **options)
      called = options.delete(:called) || what.to_s.underscore.tr("/", "_")
      asset = factory.create(what, *args, **options)
      instance_variable_set("@#{called}", asset)
      yield(asset) if block_given?
    end

    def when_there_exist(number, what, *args, **options)
      called = options.delete(:called) || "#{what.to_s.underscore.tr("/", "_")}_list"
      asset = factory.create_list(what, number, *args, **options)
      instance_variable_set("@#{called}", asset)
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
