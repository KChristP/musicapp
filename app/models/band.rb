class Band < ActiveRecord::Base
  has_many :albums

  has_many :tracks,
    through: :albums,
    source: :tracks


  validates :name, presence: true, uniqueness: true

end
