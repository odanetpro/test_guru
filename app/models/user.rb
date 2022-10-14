class User < ApplicationRecord
  def list_of_tests level
    Test.joins('JOIN passing_tests ON tests.id = passing_tests.test_id')
      .where(level: level, passing_tests: { user_id: self.id })
  end
end
