class Boat < ApplicationRecord
  has_many :assignments
  has_many :time_slots, through: :assignments

  validates :name, uniqueness: true

  def to_builder
    Jbuilder.new do |boat|
      boat.(self, :id, :name, :capacity)
    end
  end
end
