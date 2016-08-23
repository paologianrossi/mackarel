module FeatureLang

  def when_i
    yield
  end

  def i_am_taken_to(path)
    expect(current_path).to eq path
  end

  def when_there_exists_a(factory, overrides={})
    called = overrides.delete(:called) || factory
    instance_variable_set("@#{called}", FactoryGirl.create(factory, overrides))
  end

  def when_there_exist(number, factory, overrides=nil)
    instance_variable_set("@#{factory}", [])
    number.times do
      instance = FactoryGirl.create(factory, overrides)
      instance_variable_get("@#{factory}") << instance
    end
  end

  def fill_the_form_with(attributes)
    attributes.each do |field_name, value|
      field = page.find_field(field_name)
      next if field.set(value)
      select_on_form(field_name, value)
    end
  end

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

  alias and_i when_i
  alias and_also when_i
  alias as when_i

  alias when_there_exists_an when_there_exists_a
  alias and_there_exists_a when_there_exists_a
  alias and_there_exists_an when_there_exists_a

  alias and_there_exist when_there_exist

  alias and_i_can_see i_can_see

  alias i_am_taken_to_the i_am_taken_to
  alias and_i_am_taken_to i_am_taken_to
  alias and_i_am_taken_to_the i_am_taken_to
  alias and_i_find i_find
  alias i_find_a i_find
  alias i_find_an i_find
  alias and_i_find_an i_find
  alias and_i_find_a i_find
end
