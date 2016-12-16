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

    def i_can_see(something)
      expect(page).to have_content(something)
    end

    def i_cannot_see(something)
      expect(page).not_to have_content(something)
    end

    def i_find(selector, opts={})
      text = opts.delete(:with_text)
      case selector
      when String
        expect(page).to have_selector selector, text: text
      when :link
        pointing_to = opts.delete(:pointing_to)
        if pointing_to.nil?
          expect(page).to have_link text
        else
          expect(page).to have_link text, href: pointing_to
        end
      when :image
        src = opts.delete(:with_src)
        expect(page).to have_xpath(image_path(src, text))
      end
    end

    def image_path(src, alt)
      "//img#{image_filters(src, alt)}"
    end

    def image_filters(src, alt)
      guts = [alt_str(alt), src_str(src)].compact
      guts = guts.join(" and ")
      guts.empty? ? "" : "[#{guts}]"
    end

    def alt_str(alt)
      "@alt='#{alt}'" if alt
    end

    def src_str(src)
      "contains(@src, '#{src}')" if src
    end

    alias and_i_find i_find
    alias i_find_a i_find
    alias i_find_an i_find
    alias and_i_find_an i_find
    alias and_i_find_a i_find
    alias and_i_can_see i_can_see
  end
end
