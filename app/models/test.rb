class Test < ApplicationRecord
  belongs_to :categories
  has_many :questions

  def self.sort_by_category_title category_title
    Test.joins('JOIN categories ON tests.category_id = categories.id')
      .where(categories: { title: category_title })
      .order(title: :desc)
      .pluck(:title)
  end
end
