# encoding: utf-8

module SportDb

# collection of regex patterns for reuse (SportDb specific)

### todo: add a patterns.md page to  github ??
##  - add regexper pics??

############
# about ruby regexps
#
# try the rubular - Ruby regular expression editor and tester
#  -> http://rubular.com
#   code -> ??  by ??
#
#
# Jeff Avallone's Regexper - Shows State-Automata Diagrams
#  try -> http://regexper.com
#    code -> https://github.com/javallone/regexper
#
#
#  Regular Expressions | The Bastards Book of Ruby by Dan Nguyen
# http://ruby.bastardsbook.com/chapters/regexes/
#
# move to notes  regex|patterns on  geraldb.github.io ??
#

  TEAM_KEY_PATTERN  = '\A[a-z]{3,}\z'
  TEAM_KEY_PATTERN_MESSAGE = "expected three or more lowercase letters a-z /#{TEAM_KEY_PATTERN}/"

  # must start w/ letter A-Z (2nd,3rd,4th or 5th can be number or underscore _)
  TEAM_CODE_PATTERN = '\A[A-Z_][A-Z0-9_]{1,4}\z'
  TEAM_CODE_PATTERN_MESSAGE = "expected two or three or four or five uppercase letters A-Z (and 0-9_; must start with A-Z) /#{TEAM_CODE_PATTERN}/"


end # module SportDb
