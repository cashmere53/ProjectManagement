class Store < ActiveRecord::Base
  belongs_to :Inc, :foreign_key => "inc_account_id"
  has_many :Housing, dependent: :destroy
end
