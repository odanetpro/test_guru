# frozen_string_literal: true

class Admin < User
  validates :name, presence: true
  validates :surname, presence: true
end
