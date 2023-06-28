class Like < ApplicationRecord
  #Associations
  belongs_to :user
  belongs_to :tweet, counter_cache: :likes_count

  #Validations
  #=====================================
  validates :user, uniqueness: { scope: :tweet, message: "and Tweet combination already taken" }
  #=====================================
end
