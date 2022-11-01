# frozen_string_literal: true

class Space < ApplicationRecord
  has_and_belongs_to_many :users
  validates :name, presence: true

  enum status: %i[active archived]
end
