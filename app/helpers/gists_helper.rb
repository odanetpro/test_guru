# frozen_string_literal: true

module GistsHelper
  def first_characters(str, take = 25)
    str.size <= take ? str : "#{str[0..take - 1]}..."
  end

  def gist_hash(url)
    url.split('/').last
  end
end
