# frozen_string_literal: true

module ApplicationHelper
  def current_year
    Time.current.year
  end

  def github_url(author, repo)
    "https://github.com/#{author}/#{repo}"
  end

  def all_categories
    Category.all
  end

  def flash_class(key)
    classes = {
      alert: 'alert alert-danger',
      notice: 'alert alert-success',
      default: 'alert alert-light'
    }

    classes[key.to_sym] || classes[:default]
  end
end
