## note: use the local version of sportdb gems
$LOAD_PATH.unshift( File.expand_path( '../sportdb-formats/lib' ))
$LOAD_PATH.unshift( File.expand_path( '../sportdb-countries/lib' ))

## minitest setup

require 'minitest/autorun'


## our own code

require 'sportdb/leagues'



module SportDb
  module Import

class TestCatalog
  def build_country_index
    recs = CountryReader.read( "#{Test.data_dir}/world/countries.txt" )
    index = CountryIndex.new( recs )
    index
  end

  def build_league_index
    recs = SportDb::Import::LeagueReader.parse( <<TXT )
  = England =
  1       English Premier League
            | ENG PL | England Premier League | Premier League
  2       English Championship
            | ENG CS | England Championship | Championship
  3       English League One
            | England League One | League One
  4       English League Two
  5       English National League

  cup      EFL Cup
            | League Cup | Football League Cup
            | ENG LC | England Liga Cup

  = Scotland =
  1       Scottish Premiership
  2       Scottish Championship
  3       Scottish League One
  4       Scottish League Two
TXT

    leagues = SportDb::Import::LeagueIndex.new
    leagues.add( recs )
    leagues
  end


  def countries() @countries ||= build_country_index; end
  def leagues()   @leagues   ||= build_league_index; end
end

configure do |config|
  config.catalog = TestCatalog.new
end

end  # module Import
end  # module SportDb
