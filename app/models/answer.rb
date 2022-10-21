class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true
  validate :validate_number_of_answers

  scope :correct_answers, -> { where(correct: true) }

  private

  def validate_number_of_answers
    errors.add(:base, 'number of answers exceeded') if Answer.where(question_id: self.question_id).count >= 4
  end
end
