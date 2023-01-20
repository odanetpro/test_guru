# frozen_string_literal: true

module BadgesHelper
  IMAGE_NOT_FOUND_PATH = '/images/badges/badge_not_found.png'

  def rule_text(badge)
    "#{t("badge.rule.#{badge.rule}")}: #{badge.rule_criterion_value}"
  end

  def badge_image(badge)
    image_tag(badge.image_url, title: badge.title)
  rescue Sprockets::Rails::Helper::AssetNotFound
    image_tag(IMAGE_NOT_FOUND_PATH, title: badge.title)
  end

  def rules_collection
    Badge.rules.keys.map { |key| [t("badge.rule.#{key}"), key] }
  end
end
