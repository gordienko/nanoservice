class Message < ApplicationRecord
  belongs_to :user
  has_many :dispatches, inverse_of: :message, dependent: :destroy
  accepts_nested_attributes_for :dispatches
  validates :body, presence: true
  validate :at_least_one_dispatches
  default_scope -> { order(id: :desc) }

  private

  def at_least_one_dispatches
    errors.add :base, I18n.t('must_have_at_least_one_dispatch') unless dispatches.length > 0
  end
end
