# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable,
         :confirmable

  has_many :passing_tests, dependent: :destroy
  has_many :tests, through: :passing_tests
  has_many :author_of_tests, class_name: 'Test', foreign_key: 'author_id', dependent: :destroy
  has_many :gists, dependent: :destroy
  has_many :questions, through: :gists
  has_many :awards, dependent: :destroy
  has_many :badges, through: :awards

  scope :admins, -> { where(type: 'Admin') }

  def list_of_tests(level)
    Test.joins(:passing_tests)
        .where(level: level, passing_tests: { user_id: id })
  end

  def passing_test(test)
    passing_tests.order(id: :desc).find_by(test_id: test.id)
  end

  def admin?
    is_a?(Admin)
  end

  def self.admin_emails
    User.admins.pluck(:email)
  end
end
