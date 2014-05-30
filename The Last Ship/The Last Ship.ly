\version "2.18.2"

\paper {
  markup-system-spacing.basic-distance = #20
}

\header {
  title = "The Last Ship"
  composer = "Sting"
  arranger = "arr. Michael Healey"
  tagline = ""
}

global = {
  \key e \minor
  \time 3/4
  \override MultiMeasureRest.expand-limit = #1
  \compressFullBarRests
  \set Score.markFormatter = #format-mark-box-letters
}

right = \relative c' {
  \global
  % Music follows here.
  \textLengthOn
  \markLengthOn
  R2.*8-\tweak self-alignment-X #0.5 ^\markup { "Intro" }
  \mark
  \bar "||"
  s1*0^\markup { "Verse 1" }
  R2.*32
  \bar "||"
  R2.*32
  \mark
  \bar "||"
  s1*0^\markup { "Chorus" }
  R2.*8
  \bar "||"
  R2.*16
  \mark
  \bar "||"
  s1*0^\markup { "Instrumental" }
  R2.*10
  \mark
  \bar "||"
  \key f \minor
  s1*0-\tweak extra-offset #'(-7 . 0) ^\markup { "Verse 3" }
  R2.*16
  \mark
  \bar "||"
  s1*0^\markup { "Bridge" }
  \textLengthOff
  <des~ f~>2._\markup { \small \italic "gradual cresc. to end" }
  \textLengthOn
  <des f~>
  <d f>~
  q
  \bar "||"
  \key fis \minor
  <dis fis!>~
  <dis fis>
  << { fis~ fis } \\ { <b, d!>( <ais e'>) } >>
  \mark
  \bar "||"
  s1*0^\markup { "Verse 4" }
  R2.*4
  d2.\( e fis gis\)
  fis\( gis a \once \stemUp b\)
  <fis cis'> <e b'> <fis cis'>~ q
  \mark
  \bar "||"
  s1*0^\markup { "Chorus 2" }
  <<
    {
      e'2.~ e~ e~ e
      e~ e~ e~ e
      fis,~ fis~ fis e
      fis~ fis <cis_~ fis~> q
    }
    \\
    {
      fis~ fis <d a'>( <e b'>)
      fis~ fis <d a'>( <e b'>)
      cis~ cis d b
      <a cis> <b e> fis~ fis
    }
  >>
  fis''~ fis a gis2 e4
  cis2. b a gis
  fis' cis a b
  fis' e <cis d> <fis, gis>
  << { fis~ fis~ fis~ fis } \\ { d cis b gis } >>
  \textLengthOff
  <fis'~ cis'_~ fis~>2.-\tweak self-alignment-X #1 ^\markup { \small \italic "ritard." } <fis~ cis'_~ fis~> <fis~ cis'_~ fis~> <fis cis' fis>
  \textLengthOn
  \bar "|."
}

left = \relative c {
  \global
  % Music follows here.
  R2.*8
  \bar "||"
  R2.*32
  \bar "||"
  R2.*32
  \bar "||"
  R2.*8
  \bar "||"
  R2.*16
  \bar "||"
  R2.*10
  \bar "||"
  \key f \minor
  R2.*16
  \bar "||"
  R2.*4
  \bar "||"
  \key fis \minor
  R2.*4
  \bar "||"
  R2.*12
  d2. cis fis,~ fis
  \bar "||"
  <d' cis'>2.~ q
  <b a'> <e b'>
  <d cis'>~ q
  <b a'> <e b'>
  <d a'>~ q
  b e
  d cis
  fis,~ fis
  R2.*14
  fis''2. b,
  b, a
  gis e
  R2.*4
  \bar "|."
}

\score {
  \new PianoStaff \with {
    instrumentName = \markup { \right-column { "Full" "Strings" } }
  } <<
    \new Staff = "right" \right
    \new Staff = "left" { \clef bass \left }
  >>
  \layout { }
}
