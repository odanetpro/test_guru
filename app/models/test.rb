class Test < ApplicationRecord
  belongs_to :category
  belongs_to :user

  has_many :questions
  has_many :passing_tests
  has_many :users, through: :passing_tests

  def self.sort_by_category_title category_title
    Test.joins('JOIN categories ON tests.category_id = categories.id')
      .where(categories: { title: category_title })
      .order(title: :desc)
      .pluck(:title)
  end
end
