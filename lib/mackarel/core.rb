module Mackarel
  module Core
    def when_i
      yield
    end

    def create_a(what, *args, called: what, **options)
      asset = factory.create(what, *args, **options)
      if called
        called = called.to_s.underscore.tr("/", "_")
        instance_variable_set("@#{called}", asset)
      end
      yield(asset) if block_given?
      asset
    end

    def create_a_list_of(number, what, *args, called: "#{what}_list", **options)
      asset = factory.create_list(what, number, *args, **options)
      if called
        called = called.underscore.tr("/", "_")
        instance_variable_set("@#{called}", asset)
      end
      yield(asset) if block_given?
      asset
    end

    def factory
      Mackarel.config.factory
    end

    alias and_i when_i
    alias and_also when_i
    alias given when_i
    alias then_i when_i

    alias when_there_exists_a create_a
    alias when_there_exists_an create_a
    alias and_there_exists_a create_a
    alias and_there_exists_an create_a

    alias and_there_exist create_a_list_of
    alias when_there_exist create_a_list_of

  end
end
