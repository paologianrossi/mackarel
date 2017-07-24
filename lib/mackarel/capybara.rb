require "mackarel/capybara/form"

module Mackarel
  module Capybara
    def i_am_taken_to(path)
      expect(current_path).to eq path
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

    def i_find_no(selector, opts={})
      text = opts.delete(:with_text)
      case selector
      when String
        expect(page).to have_no_selector selector, text: text
      when :link
        pointing_to = opts.delete(:pointing_to)
        if pointing_to.nil?
          expect(page).to have_no_link text
        else
          expect(page).to have_no_link text, href: pointing_to
        end
      when :image
        src = opts.delete(:with_src)
        expect(page).to have_no_xpath(image_path(src, text))
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

    alias i_am_taken_to_the i_am_taken_to
    alias and_i_am_taken_to i_am_taken_to
    alias and_i_am_taken_to_the i_am_taken_to

    alias and_i_find i_find
    alias i_find_a i_find
    alias i_find_an i_find
    alias and_i_find_an i_find
    alias and_i_find_a i_find

    alias and_i_find_no i_find_no
    alias i_dont_find_a i_find_no
    alias i_dont_find_an i_find_no
    alias and_i_dont_find_an i_find_no
    alias and_i_dont_find_a i_find_no

    alias and_i_can_see i_can_see
  end
end
