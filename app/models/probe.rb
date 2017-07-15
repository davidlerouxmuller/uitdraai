class Probe < ApplicationRecord
  belongs_to :field
  has_many :degrees
end
