# frozen_string_literal: true

class CreateBadges < ActiveRecord::Migration[6.1]
  def change
    create_table :badges do |t|
      t.string :title, null: false
      t.string :image_url, null: false
      t.integer :criterion_level
      t.references :criterion_category, foreign_key: { to_table: 'categories' }
      t.boolean :criterion_alone
      t.boolean :criterion_first_try

      t.timestamps

      t.index %i[criterion_level criterion_category_id criterion_alone criterion_first_try],
              unique: true,
              name: :index_badge_rule_uniqueness
    end
  end
end
