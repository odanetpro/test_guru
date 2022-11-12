class User < ApplicationRecord
  has_many :passing_tests, dependent: :destroy
  has_many :tests, through: :passing_tests
  has_many :author_of_tests, class_name: 'Test', foreign_key: 'author_id', dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true

  def list_of_tests(level)
    Test.joins(:passing_tests)
        .where(level: level, passing_tests: { user_id: id })
  end

  def passing_test(test)
    passing_tests.order(id: :desc).find_by(test_id: test.id)
  end
end
