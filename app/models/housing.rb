class Housing < ActiveRecord::Base
  belongs_to :inc_account
  belongs_to :store

  validates :street_address,
            presence: { message: "⚠住所が入力されていません" }

  validates :rent,
            presence: { message: "⚠家賃が入力されていません" }

  validates :administration_cost,
            presence: { message: "⚠管理費が入力されていません" }

end
