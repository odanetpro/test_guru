# frozen_string_literal: true

class Badge < ApplicationRecord
  belongs_to :criterion_category, class_name: 'Category', optional: true

  has_many :awards, dependent: :destroy
  has_many :users, through: :awards

  validates :title, presence: true
  validates :image_url, presence: true
  validates :criterion_level, numericality: { only_integer: true, greater_than_or_equal_to: 0 },
                              uniqueness: { scope: %i[criterion_category_id criterion_alone criterion_first_try],
                                            message: I18n.t('validate_messages.badge_uniqueness') },
                              allow_nil: true
  validate :validate_combination_of_criteria_for_alone_test

  def award?(options = {})
    @user = options[:user]
    @test = options[:test]

    return false if criterion_level && criterion_level != @test.level
    return false if criterion_category_id && criterion_category_id != @test.category_id

    not_passed_tests_count.zero? && passed_tests_count == all_tests_count
  end

  private

  # 'criterion_alone' can only be combined with the criterion 'first try'
  def validate_combination_of_criteria_for_alone_test
    return unless criterion_alone

    return unless criterion_category_id || criterion_level || !criterion_first_try

    errors.add(:base,
               I18n.t('validate_messages.badge_invalid_rule'))
  end

  def query_params
    query_params = {}
    query_params[:id] = @test.id if criterion_alone
    query_params[:level] = @test.level if criterion_level == @test.level
    query_params[:category_id] = @test.category_id if criterion_category_id == @test.category_id

    query_params
  end

  def user_tests_scope
    @user.tests.where(query_params)
  end

  def passed_tests_count
    criterion_alone ? user_tests_scope.count : user_tests_scope.where(passing_tests: { passed: true }).distinct.count
  end

  def not_passed_tests_count
    criterion_first_try ? user_tests_scope.where(passing_tests: { passed: false }).distinct.count : 0
  end

  def all_tests_count
    Test.where(query_params).count
  end
end
