class Personality < ApplicationRecord
  belongs_to :user, optional: true

  validates :date_of_birth, presence: true

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々ー]+\z/, message: 'を全角文字で入力してください' } do
    validates :last_name
    validates :first_name
  end

  with_options presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: 'を全角文字で入力してください' } do
    validates :last_name_kana
    validates :first_name_kana
  end
end