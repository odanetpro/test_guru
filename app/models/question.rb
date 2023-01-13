# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :test

  has_many :answers, dependent: :destroy
  has_many :gists, dependent: :destroy
  has_many :users, through: :gists
  has_many :passing_tests, foreign_key: 'current_question_id',
                           dependent: :destroy

  validates :body, presence: true
end
