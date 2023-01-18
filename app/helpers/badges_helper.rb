# frozen_string_literal: true

module BadgesHelper
  IMAGE_NOT_FOUND_PATH = '/images/badges/badge_not_found.png'

  def generate_rule_text(badge)
    "#{I18n.t('badge.rule.base_text')}
     #{badge.criterion_alone? ? I18n.t('badge.rule.alone_test') : I18n.t('badge.rule.all_tests')}
     #{"#{I18n.t('badge.rule.level')} #{badge.criterion_level}" if badge.criterion_level}
     #{"#{I18n.t('badge.rule.category')} #{badge.criterion_category.title}" if badge.criterion_category_id}
     #{I18n.t('badge.rule.first_try') if badge.criterion_first_try}"
  end

  def badge_image(badge)
    image_tag(badge.image_url, title: badge.title)
  rescue Sprockets::Rails::Helper::AssetNotFound
    image_tag(IMAGE_NOT_FOUND_PATH, title: badge.title)
  end
end
