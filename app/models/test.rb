class Test < ApplicationRecord
  def self.sort_by_category_title category_title
    Test.joins('JOIN categories ON tests.category_id = categories.id').where('categories.title = ?', category_title).order('tests.title ASC').pluck('tests.title')
  end
end
