class Distance < ActiveRecord::Base
  belongs_to :facility
  belongs_to :housing
  belongs_to :store
  belongs_to :inc_account
end
