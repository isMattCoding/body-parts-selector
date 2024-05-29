class Body < ApplicationRecord
  validates :parts, presence: false, parts: true
end
