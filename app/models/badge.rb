# frozen_string_literal: true

class Badge < ApplicationRecord
  enum rule: {
    passing_all_tests_from_category: 0,
    passing_test_on_a_given_attempt: 1,
    passing_all_tests_of_level: 2
  }

  has_many :awards, dependent: :destroy
  has_many :users, through: :awards

  validates :title, presence: true
  validates :image_url, presence: true
  validates :rule, presence: true, uniqueness: { scope: :rule_criterion_value }
  validates :rule_criterion_value, presence: true

  validate :validate_rule

  private

  def validate_rule
    errors.add(:base, :badge_invalid_rule) unless Badge.rules.key?(rule)
  end
end
