# frozen_string_literal: true

module AnswersHelper
  def show_correct(correct)
    correct ? t('.y') : t('.n')
  end
end
