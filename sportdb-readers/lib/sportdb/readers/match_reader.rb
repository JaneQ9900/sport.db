# encoding: utf-8

module SportDb

class MatchReaderV2    ## todo/check: rename to MatchReaderV2 (use plural?) why? why not?

  def self.config()  Import.config; end



  def self.read( path, season: nil )   ## use - rename to read_file or from_file etc. - why? why not?
    txt = File.open( path, 'r:utf-8' ).read
    parse( txt, season: season )
  end

  def self.parse( txt, season: nil )
    recs = LeagueOutlineReader.parse( txt, season: season )
    pp recs

    recs.each do |rec|
      league = Sync::League.find_or_create( rec[:league] )
      season = Sync::Season.find_or_create( rec[:season] )

      ## hack for now: switch lang
      if ['de', 'at'].include?( league.country.key )
        SportDb.lang.lang = 'de'
        DateFormats.lang  = 'de'
      elsif ['fr'].include?( league.country.key )
        SportDb.lang.lang = 'fr'
        DateFormats.lang  = 'fr'
      elsif ['it'].include?( league.country.key )
        SportDb.lang.lang = 'it'
        DateFormats.lang  = 'it'
      elsif ['es', 'mx'].include?( league.country.key )
        SportDb.lang.lang = 'es'
        DateFormats.lang  = 'es'
      elsif ['pt', 'br'].include?( league.country.key )
        SportDb.lang.lang = 'pt'
        DateFormats.lang  = 'pt'
      else
        SportDb.lang.lang = 'en'
        DateFormats.lang  = 'en'
      end


      ## todo/fix:
      ##    always auto create
      ##   1) check for clubs count on event/stage - only if count == 0 use autoconf!!!
      ##   2) add lang switch for date/lang too!!!!

      event = Sync::Event.find_or_create( league: league, season: season )

      stage = if rec[:stage]
        Sync::Stage.find_or_create( rec[:stage], event: event )
      else
        nil
      end


      auto_conf_clubs, _ = AutoConfParser.parse( rec[:lines],
                                                 start: event.start_at )

      ## step 1: map/find clubs
      club_recs    = []   ## array of struct records
      club_mapping = {}   ## name => database (ActiveRecord) record

      ## note: loop over keys (holding the names); values hold the usage counter!! e.g. 'Arsenal' => 2, etc.
      country = league.country
      auto_conf_clubs.keys.each do |name|
        club_rec = config.clubs.find_by!( name: name, country: country )
        club_recs << club_rec

        club = Sync::Club.find_or_create( club_rec )
        club_mapping[ name ] = club
      end


      ## todo/fix: check if all clubs are unique
      ##   check if uniq works for club record (struct) - yes,no ??
      clubs = club_mapping.values.uniq


      ## step 2: add to database
      teams     =  stage ? stage.teams    : event.teams
      team_ids  =  stage ? stage.team_ids : event.team_ids

      clubs.each do |club|
        ## add teams to event
        ##   for now check if team is alreay included
        ##   todo/fix: clear/destroy_all first - why? why not!!!

        teams << club    unless team_ids.include?( club.id )
      end



      ## todo/fix: set lang for now depending on league country!!!
      parser = MatchParserSimpleV2.new( rec[:lines],
                                club_mapping,
                                event.start_at )   ## note: keep season start_at date for now (no need for more specific stage date need for now)

      match_recs, round_recs = parser.parse

      pp round_recs

      round_recs.each do |round_rec|
        ## quick hack:  if pos missing fill with dummy 999 for now
        round_rec.pos = 999    if round_rec.pos.nil?
        round = Sync::Round.find_or_create( round_rec, event: event )  ## check: use/rename to EventRound why? why not?
      end

      match_recs.each do |match_rec|
        ## todo/fix: pass along stage (if present): stage  - optional!!!!
        match = Sync::Match.create_or_update( match_rec, event: event )
      end
    end

    recs
  end # method read
end # class MatchReaderV2
end # module SportDb
