# frozen_string_literal: true

module Rules
  class PassingAllTestsOfLevel < BaseRule
    def satisfy?
      level = @value

      return false if @test.level != level.to_i || !str_is_integer?(level)

      passed = @user.tests.where(level: level, passing_tests: { passed: true }).distinct.count
      all = Test.where(level: level).count

      passed == all
    end
  end
end
