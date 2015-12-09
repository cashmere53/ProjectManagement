class Housing < ActiveRecord::Base
  belongs_to :inc_account
  belongs_to :store
end
