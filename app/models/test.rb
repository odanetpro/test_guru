class Test < ApplicationRecord
  belongs_to :category
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  has_many :questions, dependent: :destroy
  has_many :passing_tests, dependent: :destroy
  has_many :users, through: :passing_tests

  validates :title, presence: true,
                    uniqueness: { scope: :level }

  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  scope :by_level, -> (level) { where(level: level) }
  scope :easy_level, -> { by_level([0, 1]) }
  scope :medium_level, -> { by_level(2..4) }
  scope :difficult_level, -> { by_level(5..Float::INFINITY) }

  scope :by_category_title, -> (category_title) { joins(:category)
                                                         .where(categories: { title: category_title })
                                                         .order(title: :desc) }
  
  def self.sort_by_category_title category_title
    by_category_title(category_title).pluck(:title)
  end
end
