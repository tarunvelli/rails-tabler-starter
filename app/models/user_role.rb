class UserRole < ApplicationRecord
  belongs_to :user
  belongs_to :space
  belongs_to :role
end
