# frozen_string_literal: true

class BaseRule
  def initialize(passing_test:, value:)
    @user = passing_test.user
    @test = passing_test.test
    @value = value
  end

  def satisfy?
    raise "#{__method__} undefined for #{self.class}"
  end

  private

  def str_is_integer?(str)
    str.to_i.to_s == str
  end
end
