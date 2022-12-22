# frozen_string_literal: true

module TestsHelper
  def disabled_class(test)
    'disabled' if test.questions.count.zero?
  end
end
