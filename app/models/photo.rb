class Photo < ActiveRecord::Base
  belongs_to :user
  has_many :ratings

  def avg_rating
    if self.ratings.count > 0
      (self.ratings.inject(0) { |sum, rating| sum + rating.score }.to_f / self.ratings.count).to_s + " / 10"
    else
      "No ratings"
    end
  end

end
