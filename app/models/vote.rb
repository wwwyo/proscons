class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :ballot_box
end
