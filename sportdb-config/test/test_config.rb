# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_config.rb


require 'helper'

class TestConfig < MiniTest::Test

  def test_teams
    SportDb::Import.config.clubs_dir = '../../../openfootball/clubs'

    pp SportDb::Import.config.teams

    pp SportDb::Import.config.errors

    assert true ## assume ok if we get here
  end  # method test_teams

end # class TestConfig
