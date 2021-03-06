class Movie < ApplicationRecord
  belongs_to :director
  include PgSearch
  multisearchable against: [ :title, :syllabus ]

  include PgSearch
  pg_search_scope :search_by_title_and_syllabus,
    against: [ :title, :syllabus ],
    using: {
      tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end

#Searching through association
#We want chris nolan to return Nolan's movies:



class Movie < ApplicationRecord
  belongs_to :director
  include PgSearch
  pg_search_scope :global_search,
    against: [ :title, :syllabus ],
    associated_against: {
      director: [ :first_name, :last_name ]
    },
    using: {
      tsearch: { prefix: true }
    }
end


