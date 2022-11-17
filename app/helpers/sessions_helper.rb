module SessionsHelper
  def show_flash(options = {})
    tag = options[:tag] || :p
    key = options[:key] || :alert

    content_tag tag, flash[key], class: "flash #{key}" if flash[key]
  end
end
