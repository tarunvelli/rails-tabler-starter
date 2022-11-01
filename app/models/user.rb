# frozen_string_literal: true

class User < ApplicationRecord
  has_and_belongs_to_many :spaces

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  enum status: %i[active archived]

  def name
    "#{first_name} #{last_name}"
  end
end
