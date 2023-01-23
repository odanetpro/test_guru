# frozen_string_literal: true

module Rules
  class PassingTestOnAGivenAttempt < BaseRule
    def satisfy?
      attempt = @value

      return false unless str_is_integer?(attempt)

      passed = @user.tests.where(id: @test.id, passing_tests: { passed: true }).count
      not_passed = @user.tests.where(id: @test.id, passing_tests: { passed: false }).count

      passed == 1 && passed + not_passed == attempt.to_i
    end
  end
end
