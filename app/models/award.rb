# frozen_string_literal: true

class Award < ApplicationRecord
  belongs_to :user
  belongs_to :badge

  scope :by_badge_id, ->(id) { where(badge_id: id) }
end
