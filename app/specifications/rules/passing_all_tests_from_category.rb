# frozen_string_literal: true

module Rules
  class PassingAllTestsFromCategory < BaseRule
    def satisfy?
      category = Category.find_by(title: @value)
      return false if @test.category_id != category.id

      passed = @user.tests.where(category_id: category.id, passing_tests: { passed: true }).distinct.count
      all = Test.where(category_id: category.id).count

      passed == all
    rescue ActiveRecord::RecordNotFound
      false
    end
  end
end
