class Song < ApplicationRecord
    validates :title, presence: true
    validates :title, uniqueness: { scope: [:artist_name, :release_year],
        message: "Artist cannot release the same song in one year" }
    
    validates :released, inclusion: { in: [true, false] }
    with_options if: :released? do |song|
        song.validates :release_year, numericality: { less_than_or_equal_to: Time.now.year }
        song.validates :release_year, presence: true
    end

    def released? 
        released
    end

    validates :artist_name, presence: true

end
