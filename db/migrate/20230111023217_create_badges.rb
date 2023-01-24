# frozen_string_literal: true

class CreateBadges < ActiveRecord::Migration[6.1]
  def change
    create_table :badges do |t|
      t.string :title, null: false
      t.string :image_url, null: false
      t.integer :rule, null: false
      t.string :rule_criterion_value, null: false

      t.timestamps
      t.index %i[rule rule_criterion_value], unique: true
    end
  end
end
