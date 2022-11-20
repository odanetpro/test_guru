# frozen_string_literal: true

class PassingTest < ApplicationRecord
  PASSING_PERCENTAGE = 85

  belongs_to :test
  belongs_to :user
  belongs_to :current_question, class_name: 'Question', optional: true

  before_validation :before_validation_set_current_question, on: %i[create update]

  def accept!(answer_ids)
    self.correct_questions += 1 if correct_answer?(answer_ids)
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

  private

  def before_validation_set_current_question
    self.current_question_number += 1
    self.current_question = next_question
  end

  def next_question
    return test.questions.first if current_question.nil?

    test.questions.order(:id).where('id > :current_question_id',
                                    current_question_id: current_question.id).first
  end

  def correct_answer?(answer_ids)
    current_question.answers.correct.ids.sort == answer_ids.to_a.map(&:to_i).sort
  end
end
