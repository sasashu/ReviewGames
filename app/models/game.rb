class Game < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :game_tags, dependent: :destroy
  has_many :tags, through: :game_tags, dependent: :destroy
  # 結びついていない中間テーブルを繋ぐために双方にthroughを使用。

  validates :title, presence: true
  validates :item_caption, presence: true
  validates :sales_date, presence: true
  validates :label, presence: true
  validates :jan, presence: true
  validates :item_url, presence: true
  validates :image_url, presence: true


# 星の中身が空では無かったら返す
# round(1)で小数点第一位まで表示
  def avg_score
    unless self.reviews.empty?
      reviews.average(:rate).round(1).to_f
    else
      0.0
    end
  end

# 100を掛けて5で割る事で百分率で表示
  def review_score_percentage
    unless self.reviews.empty?
      reviews.average(:rate).round(1).to_f*100/5
    else
      0.0
    end
  end
end
