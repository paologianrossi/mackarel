module Mackarel
  module Capybara
    def fill_autocomplete(field="input[data-autocomplete]", with:)
      fill_in field, with: with
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

    def submit_the_form
      page.find("form").find(:button).click
    end

    def i_can_see(something)
      expect(page).to have_content(something)
    end

    def i_find(selector, opts={})
      text = opts.delete(:with_text)
      case selector
      when String
        expect(page).to have_selector selector, text: text
      when :link
        pointing_to = opts.delete(:pointing_to)
        expect(page).to have_link text, href: pointing_to
      when :image
        src = opts.delete(:with_src)
        if text.blank?
          expect(page).to have_xpath("//img[@src='#{src}']")
        else
          expect(page).to have_xpath("//img[@alt='#{text}' and @src='#{src}']")
        end
      end
    end
  end
end
