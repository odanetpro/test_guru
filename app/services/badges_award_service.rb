# frozen_string_literal: true

class BadgesAwardService
  Result = Struct.new(:badges) do
    def success?
      badges.any?
    end

    def badges_ids
      badges.map(&:id)
    end
  end

  def initialize(user, test)
    @user = user
    @test = test
    @badges = []
  end

  def call
    Badge.find_each do |badge|
      if send(badge.rule, badge.rule_criterion_value)
        @badges << badge
        @user.badges << badge
      end
    end

    Result.new(@badges)
  end

  private

  def passing_all_tests_from_category(value)
    category = Category.find_by(title: value)
    return false if @test.category_id != category.id

    passed = @user.tests.where(category_id: category.id, passing_tests: { passed: true }).distinct.count
    all = Test.where(category_id: category.id).count

    passed == all
  rescue ActiveRecord::RecordNotFound
    false
  end

  def passing_all_tests_of_level(level)
    return false if @test.level != level.to_i || !str_is_integer?(level)

    passed = @user.tests.where(level: level, passing_tests: { passed: true }).distinct.count
    all = Test.where(level: level).count

    passed == all
  end

  def passing_test_on_a_given_attempt(attempt)
    return false unless str_is_integer?(attempt)

    passed = @user.tests.where(id: @test.id, passing_tests: { passed: true }).count
    not_passed = @user.tests.where(id: @test.id, passing_tests: { passed: false }).count

    passed == 1 && passed + not_passed == attempt.to_i
  end

  def str_is_integer?(str)
    str.to_i.to_s == str
  end

  def method_missing(_name, *_args)
    false
  end
end
