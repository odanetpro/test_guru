# frozen_string_literal: true

class PassingTest < ApplicationRecord
  PASSING_PERCENTAGE = 85

  belongs_to :test
  belongs_to :user
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_first_question, on: :create
  before_validation :before_validation_set_current_question, on: :update

  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids)
    save!
  end

  def set_complited!
    self.current_question = nil
    save!
  end

  def complited?
    current_question.nil?
  end

  def sucsessful?
    success_rate >= PASSING_PERCENTAGE
  end

  def success_rate
    self.correct_questions * 100.0 / self.test.questions.count
  end

  def set_passed!
    self.passed = true
    save!
  end

  def passed?
    passed
  end

  def time_left
    time_left = self.test.time_to_pass - (Time.current - created_at).ceil
    time_left.negative? ? 0 : time_left
  end

  def check_left_time!
    return unless test.with_timer?

    set_complited! if time_left.zero?
  end

  private

  def before_validation_set_first_question
    self.current_question_number = 1
    self.current_question = test.questions.first
  end

  def before_validation_set_current_question
    return if complited?

    self.current_question_number += 1
    self.current_question = next_question
  end

  def next_question
    test.questions.order(:id).where('id > :current_question_id',
                                    current_question_id: current_question.id).first
  end

  def correct_answer?(answer_ids)
    current_question.answers.correct.ids.sort == answer_ids.to_a.map(&:to_i).sort
  end
end
