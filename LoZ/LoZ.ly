\version "2.18.2"

global = {
  \key d \dorian
  \numericTimeSignature
  \time 4/4
}

\paper {
  indent = 10
}

soprano = \relative c'' {
  \global
  % Music follows here. 
  \repeat unfold 2 {
  a4 d,2 f4 |
  a d,2 f4 |
  a8 c b4 g f8 g |
  \time 5/4
  a4 d, c8 e d4 r |
  \time 4/4
  }
}

alto = \relative c' {
  \global
  % Music follows here.
  d 1 |
  a |
  c4 d b2 |
  r4 d c a r |
  d1 |
  a |
  gis2 ais |
  c2. a4  r |
}

tenor = \relative c' {
  \global
  % Music follows here.
  a1 |
  d,2 c |
  d2. g4 |
  r a2 f4 r |
  a1 |
  d,2 c |
  b2 cis |
  ees4 f g fis r |
}

bass = \relative c {
  \global
  % Music follows here.
  d1 |
  f, |
  g |
  r4 d' a d r |
  \time 4/4
  d1 |
  f, |
  e2 fis |
  aes4 bes c d  r |
}

verse = \lyricmode {
  % Lyrics follow here.
  
}

\score {
  \new ChoirStaff <<
    \new Staff \with {
      instrumentName = \markup \center-column { "S" "A" }
    } <<
      \new Voice = "soprano" { \voiceOne \soprano }
      \new Voice = "alto" { \voiceTwo \alto }
    >>
    \new Lyrics \with {
      \override VerticalAxisGroup #'staff-affinity = #CENTER
    } \lyricsto "soprano" \verse
    \new Staff \with {
      instrumentName = \markup \center-column { "T" "B" }
    } <<
      \clef bass
      \new Voice = "tenor" { \voiceOne \tenor }
      \new Voice = "bass" { \voiceTwo \bass }
    >>
  >>
  \layout { }
  \midi {
    \context {
      \Staff
      midiInstrument = "ocarina"
    }
  }
}
