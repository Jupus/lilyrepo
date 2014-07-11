\version "2.18.2"

#(set-global-staff-size 22)

\include "../Includes/LilyJAZZ.ily"

\paper {
  indent = #15
}

\header {
  title = \markup { \fontsize #3 \override #'(font-name . "LilyJAZZ Text") "Jazz Crimes" }
  subtitle = \markup { \override #'(font-name . "LilyJAZZ Text") "as played by Joshua Redman" }
  composer = \markup { \override #'(font-name . "LilyJAZZ Text") "J. Redman" }
  tagline = ""
}

global = {
  \key fis \minor
  \time 4/4
  \jazzOn
}

right = \relative c' {
  \global
  % Music follows here.
  r8 <ais dis fis> r4 <g cis fis>8 r4 <aes d fis>8
  r4 <g des' fis>8 r4 <gis d' fis>8 <g des' fis>4
  r8 <bes e ges> r4 <ais dis fis>8 r4 <c e fis>8~
  q16 <b d fis>8. r4 r16 <b dis fis>8. r16 \once \override NoteHead.extra-spacing-width = #'(0 . 2.5) <b disis a'>8.
  \bar ":|."
  \break
  <b d fis>4. <g cis fis>8~ q2
  <ais cis fis>4. <fis bis fis'>8~ q2
  <a c ges'>4. <aes ces f>8~ q2
  <a cis e>4. <a b fis'>8~ q2
  <b d fis>4. <g cis fis>8~ q2
  <ais cis fis>4. <fis bis fis'>8~ q2
  <gis b e>4. <ais cis fisis>8~ q2
  <ais cis fis>4. <b disis a'>8~ q2
  \bar ":|."
}

left = \relative c, {
  \global
  % Music follows here.
  r8 <fis e'> r4 <a e'>8 r4 <bes e>8
  r4 ees8 r4 e8 ees4
  r8 <c g'> r4 <b fis'>8 r4 <d a'>8~
  q16 <g, d'>8. r4 r16 <gis dis'>8. r16 <cis eis>8.
  \bar ":|."
  \break
  <e g>4. <a, e'>8~ q2
  <dis fis>4. <gis, dis'>8~ q2
  <f ees'>4. <bes d>8~ q2
  <fis cis'>4. <b dis>8~ q2
  <e g>4. <a, e'>8~ q2
  <dis fis>4. <gis, dis'>8~ q2
  <f e'>4. <ais dis>8~ q2
  <gis dis'>4. <cis eis>8~ q2
  \bar ":|."
}

\score {
  \new PianoStaff \with {
    instrumentName = "Piano"
    \override InstrumentName.font-name = "LilyJAZZ Text"
  } <<
    \new Staff = "right" \right
    \new Staff = "left" { \clef bass \left }
  >>
  \layout { }
  \midi { \tempo 4=110 }
}
