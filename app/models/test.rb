class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  has_many :questions, dependent: :destroy
  has_many :passing_tests, dependent: :destroy
  has_many :users, through: :passing_tests

  scope :by_level, -> (level) { where(level: level) }
  scope :easy_level, -> { by_level([0, 1]) }
  scope :medium_level, -> { by_level(2..4) }
  scope :difficult_level, -> { by_level(5..Float::INFINITY) }

  def self.sort_by_category_title category_title
    Test.joins(:category)
      .where(categories: { title: category_title })
      .order(title: :desc)
      .pluck(:title)
  end
end
