class Deck < ApplicationRecord
  has_many :cards, dependent: :destroy
  belongs_to :user
  validates :name, presence: true
end
