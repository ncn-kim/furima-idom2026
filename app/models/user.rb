class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #正規表現
  PASSWORD_REGEX = /\A(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d]+\z/
  NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
  KANA_REGEX = /\A[ァ-ヶー]+\z/

  validates :nickname, presence: true
  validates :last_name, presence: true,
                        format: { with: NAME_REGEX }

  validates :first_name, presence: true,
                         format: { with: NAME_REGEX }

  validates :last_name_kana, presence: true,
                             format: { with: KANA_REGEX }

  validates :first_name_kana, presence: true,
                              format: { with: KANA_REGEX }

  validates :birth_date, presence: true

  validates :password,
            format: {
              with: PASSWORD_REGEX,
              message: 'は半角英数字混合で入力してください'
            }
end
