module Mackarel
  module Capybara
    def fill_the_form_with(attributes)
      attributes.each do |field_name, value|
        field = page.find_field(field_name)
        next if field.set(value)
        select_on_form(field_name, value)
      end
    end

    def fill_autocomplete(field="input[data-autocomplete]", options)
      fill_in field, with: options.delete(:with)
      page.execute_script %Q{ $('#{field}').trigger("focus") }
      page.execute_script %Q{ $('#{field}').trigger("keydown") }
      sleep 1
      page.execute_script %Q{ $('.ui-menu-item a:contains("#{with}")').trigger("mouseenter").trigger("click"); }
    end

    def select_on_form(field_name, value)
      field = page.find_field(field_name)
      [value].flatten.each do |single_value|
        field.find(:option, single_value).select_option
      end
    end

    def submit_the_form(selector="")
      page.find("form#{selector}").find(:button).click
    end
  end
end
