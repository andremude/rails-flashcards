class Deck < ApplicationRecord
  has_many :cards, dependent: :destroy
  belongs_to :user
end
