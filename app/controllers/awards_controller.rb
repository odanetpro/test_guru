# frozen_string_literal: true

class AwardsController < ApplicationController
  def index
    @user_awards = []

    current_user.badges.distinct.each do |badge|
      @user_awards << {
        badge: badge,
        count: current_user.awards.by_badge_id(badge.id).count
      }
    end
  end
end
