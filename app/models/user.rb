class User < ApplicationRecord
  extend Enumerize
  has_many :messages, dependent: :destroy
  acts_as_token_authenticatable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enumerize :role, in: { user: 0, admin: 1 }, predicates: true, scope: true
end
