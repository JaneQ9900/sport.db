# encoding: utf-8

###
#  to run use
#     ruby -I ./lib -I ./test test/test_changes.rb

require 'helper'

class TestChanges < MiniTest::Test

  def test_scores
    game1 = Game.new
    game1.score1 = 1
    game1.score2 = 2

    game2 = Game.new
    game2.score1   = 1
    game2.score2   = 1
    game2.score1p  = 5
    game2.score2p  = 3

    game_attribs = {
      score1: 1,
      score2: 2,
      score1et: nil,
      score2et: nil,
      score1p:  nil,
      score2p:  nil
    }

    assert_equal  false, game1.check_for_changes( game_attribs )
    assert_equal  true,  game2.check_for_changes( game_attribs )
  end

  def test_play_at
    game1 = Game.new
    game1.score1 = 1
    game1.score2 = 2
    game1.play_at = DateTime.new( 2012, 11, 5 )

    game2 = Game.new
    game2.score1   = 1
    game2.score2   = 2
    game2.play_at = DateTime.new( 2012, 12, 24 )

    game_attribs = {
      score1:  1,
      score2:  2,
      play_at: DateTime.new( 2012, 11, 5 )
    }

    assert_equal  false, game1.check_for_changes( game_attribs )
    assert_equal  true,  game2.check_for_changes( game_attribs )
  end

  def test_group_id
    game1 = Game.new
    game1.score1 = 1
    game1.score2 = 2
    game1.group_id = 1

    game2 = Game.new
    game2.score1   = 1
    game2.score2   = 2
    game2.group_id = 2

    game_attribs = {
      score1:  1,
      score2:  2,
      group_id: 1
    }

    assert_equal  false, game1.check_for_changes( game_attribs )
    assert_equal  true,  game2.check_for_changes( game_attribs )
  end


end # class TestChanges
