class Store < ActiveRecord::Base
  belongs_to :Inc, :foreign_key => "inc_account_id"
  has_many :Housing, dependent: :destroy

  validates :store_name,
            presence: { message: "⚠店舗名が入力されていません" },
            length: {maximum: 50, message: "⚠︎50文字以下で入力してください" }


  validates :street_address,
            presence: { message: "⚠住所が入力されていません" },
            length: {maximum: 50, message: "⚠︎50文字以下で入力してください" }

  validates :postal_code,
            presence: { message: "⚠郵便番号が入力されていません" },
            length: {in: 7..7, message: "⚠︎郵便番号は数字のみ7文字で入力してください" },
            format: {with: /\A[0-9]+$\Z/, message: "⚠︎数字のみの形式で入力してください(XXX-YYYY→XXXYYYY)"}
end
