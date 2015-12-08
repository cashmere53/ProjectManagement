class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :inc_account
  belongs_to :store
  belongs_to :housing
end
