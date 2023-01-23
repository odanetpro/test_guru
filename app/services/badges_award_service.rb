# frozen_string_literal: true

class BadgesAwardService
  RULES = {
    passing_all_tests_from_category: Rules::PassingAllTestsFromCategory,
    passing_test_on_a_given_attempt: Rules::PassingTestOnAGivenAttempt,
    passing_all_tests_of_level: Rules::PassingAllTestsOfLevel
  }.freeze

  Result = Struct.new(:badges) do
    def success?
      badges.any?
    end

    def badges_ids
      badges.map(&:id)
    end
  end

  def initialize(passing_test)
    @passing_test = passing_test
    @badges = []
  end

  def call
    Badge.find_each do |badge|
      rule = RULES[badge.rule.to_sym].new(passing_test: @passing_test,
                                          value: badge.rule_criterion_value)
      add_badge(badge) if rule.satisfy?
    end

    Result.new(@badges)
  end

  private

  def add_badge(badge)
    @badges << badge
    @passing_test.user.badges << badge
  end
end
