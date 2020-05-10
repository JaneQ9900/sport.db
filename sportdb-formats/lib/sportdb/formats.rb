# encoding: utf-8


## 3rd party gems
require 'alphabets'      # downcase_i18n, unaccent, variants, ...
require 'date/formats'   # DateFormats.parse, find!, ...
require 'csvreader'

require 'zip'     ## todo/check: if zip is alreay included in a required module



def read_csv( path )
  CsvHash.read( path, :header_converters => :symbol )
end

def parse_csv( txt )
  CsvHash.parse( txt, :header_converters => :symbol )
end


## more sportdb libs/gems
require 'sportdb/langs'


## todo/fix: move shortcut to sportdb/langs!!!
module SportDb
  Logging = LogUtils::Logging     ## logging machinery shortcut; use LogUtils for now
end



###
# our own code
require 'sportdb/formats/version' # let version always go first

require 'sportdb/formats/config'  # let "global" config "framework" go next - why? why not?

require 'sportdb/formats/outline_reader'
require 'sportdb/formats/datafile'
require 'sportdb/formats/datafile_package'
require 'sportdb/formats/package'
require 'sportdb/formats/season_utils'

require 'sportdb/formats/name_helper'
require 'sportdb/formats/parser_helper'

require 'sportdb/formats/structs/country'
require 'sportdb/formats/structs/season'
require 'sportdb/formats/structs/league'
require 'sportdb/formats/structs/team'
require 'sportdb/formats/structs/round'
require 'sportdb/formats/structs/group'
require 'sportdb/formats/structs/match'
require 'sportdb/formats/structs/matchlist'
require 'sportdb/formats/structs/standings'
require 'sportdb/formats/structs/team_usage'


require 'sportdb/formats/score/score_formats'
require 'sportdb/formats/score/score_parser'
require 'sportdb/formats/goals'


require 'sportdb/formats/match/mapper'
require 'sportdb/formats/match/mapper_teams'
require 'sportdb/formats/match/match_parser'
require 'sportdb/formats/match/match_parser_auto_conf'
require 'sportdb/formats/match/conf_parser'


require 'sportdb/formats/country/country_reader'
require 'sportdb/formats/country/country_index'


## add convenience helper
module SportDb
module Import
class Country
  def self.read( path )  CountryReader.read( path ); end
  def self.parse( txt )  CountryReader.parse( txt ); end
end   # class Country
end   # module Import
end   # module SportDb



## let's put test configuration in its own namespace / module
module SportDb
class Test    ## todo/check: works with module too? use a module - why? why not?

  ####
  #  todo/fix:  find a better way to configure shared test datasets - why? why not?
  #    note: use one-up (..) directory for now as default - why? why not?
  def self.data_dir()        @data_dir ||= '../test'; end
  def self.data_dir=( path ) @data_dir = path; end
end
end   # module SportDb




puts SportDb::Formats.banner   # say hello
