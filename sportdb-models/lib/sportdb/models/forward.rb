
### forward references
##   require first to resolve circular references

module SportDb
  module Model

  Prop      = ConfDb::Model::Prop

  ## todo: why? why not use include WorldDb::Models here???
  Continent = WorldDb::Model::Continent
  Country   = WorldDb::Model::Country
  State     = WorldDb::Model::State
  City      = WorldDb::Model::City

  Person    = PersonDb::Model::Person

  ## nb: for now only team and league use worlddb tables
  #   e.g. with belongs_to assoc (country,region)

  class Assoc  < ActiveRecord::Base ; end
  class Team   < ActiveRecord::Base ; end
  class League < ActiveRecord::Base ; end
  class Ground < ActiveRecord::Base ; end
  class Goal   < ActiveRecord::Base ; end

  end

  ## add backwards compatible n convenience namespace
  Models = Model
end # module SportDb


module WorldDb
  module Model

  # add alias? why? why not? # is there a better way?
  #  - just include SportDb::Models  - why? why not?
  #  - just include once in loader??
  Assoc  = SportDb::Model::Assoc
  Team   = SportDb::Model::Team
  League = SportDb::Model::League
  Ground = SportDb::Model::Ground

  end
end


module PersonDb
  module Model
    Goal  = SportDb::Model::Goal
  end
end


