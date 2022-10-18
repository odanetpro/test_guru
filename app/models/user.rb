class User < ApplicationRecord
  has_many :passing_tests, dependent: :destroy
  has_many :tests, through: :passing_tests
  has_many :author_of_tests, class_name: 'Test', foreign_key: 'author_id', dependent: :destroy

  def list_of_tests level
    Test.joins('JOIN passing_tests ON tests.id = passing_tests.test_id')
      .where(level: level, passing_tests: { user_id: self.id })
  end
end
