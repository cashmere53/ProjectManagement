class Housing < ActiveRecord::Base
  belongs_to :inc_account
  belongs_to :store

  validates :street_address,
            presence: { message: "⚠住所が入力されていません" },
            length: {maximum: 50, message: "⚠︎50文字以下で入力してください" }

  validates :rent,
            presence: { message: "⚠家賃が入力されていません" },
            length: {maximum: 50, message: "⚠︎50文字以下で入力してください" },
            format: {with: /\A[0-9]+$\Z/, message: "⚠︎入力できるのは数字のみです" }

  validates :administration_cost,
            presence: { message: "⚠管理費が入力されていません" },
            length: {maximum: 50, message: "⚠︎50文字以下で入力してください" },
            format: {with: /\A[0-9]+$\Z/, message: "⚠︎入力できるのは数字のみです" }

  validates :housing_type,
            length: {maximum: 50, message: "⚠︎50文字以下で入力してください" }

  validates :direction,
            length: {maximum: 50, message: "⚠︎50文字以下で入力してください" }

  validates :layout,
            presence: { message: "⚠間取りが入力されていません" },
            length: {maximum: 50, message: "⚠︎50文字以下で入力してください" }

  validates :area,
            presence: { message: "⚠部屋の面積が入力されていません" },
            length: {maximum: 50, message: "⚠︎50文字以下で入力してください" },
            format: {with: /\A[0-9]+$\Z/, message: "⚠︎入力できるのは数字のみです" }

  validates :structure,
            length: {maximum: 50, message: "⚠︎50文字以下で入力してください" }

  validates :floor,
            presence: { message: "⚠階建が入力されていません" },
            length: {maximum: 50, message: "⚠︎50文字以下で入力してください" },
            format: {with: /\A[0-9]+$\Z/, message: "⚠︎入力できるのは数字のみです" }

  validates :deposit,
            presence: { message: "⚠敷金が入力されていません" },
            length: {maximum: 50, message: "⚠︎50文字以下で入力してください" },
            format: {with: /\A[0-9]+$\Z/, message: "⚠︎入力できるのは数字のみです" }

  validates :recompense,
            presence: { message: "⚠礼金が入力されていません" },
            length: {maximum: 50, message: "⚠︎50文字以下で入力してください" },
            format: {with: /\A[0-9]+$\Z/, message: "⚠︎入力できるのは数字のみです" }

  validates :security_money,
            presence: { message: "⚠保証金が入力されていません" },
            length: {maximum: 50, message: "⚠︎50文字以下で入力してください" },
            format: {with: /\A[0-9]+$\Z/, message: "⚠︎入力できるのは数字のみです" }

  validates :shikibiki,
            length: {maximum: 50, message: "⚠︎50文字以下で入力してください" },
            format: {with: /\A[0-9]+$\Z/, message: "⚠︎入力できるのは数字のみです" }

  validates :insurance,
            presence: { message: "⚠保険料が入力されていません" },
            length: {maximum: 50, message: "⚠︎50文字以下で入力してください" },
            format: {with: /\A[0-9]+$\Z/,message: "⚠︎入力できるのは数字のみです" }

  validates :parking,
            length: {maximum: 50, message: "⚠︎50文字以下で入力してください" },
            numericality: { :only_integer => true, message: "⚠︎入力できるのは数字のみです" }

  validates :trading_aspect,
            presence: { message: "⚠取引態様が入力されていません" },
            length: {maximum: 50, message: "⚠︎50文字以下で入力してください" }

  validates :another_cost,
            length: {maximum: 50, message: "⚠︎50文字以下で入力してください" },
            format: {with: /\A[0-9]+$\Z/, message: "⚠︎入力できるのは数字のみです" }

  validates :vacancy,
            length: {maximum: 50, message: "⚠︎50文字以下で入力してください" }

  validates :detail,
            length: {maximum: 250, message: "⚠︎250文字以下で入力してください" }

  validates :plan,
            presence: { message: "⚠契約プランが選択されていません" }

end
