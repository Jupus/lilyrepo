\version "2.18.0"

rightOne = \relative c'''' {
  \ottava #1
  f4 d b aes
  \ottava #0
  f d b aes
  f d b aes
  f << { \once \override NoteColumn.force-hshift = #-1 g'''2.-\tweak self-alignment-X #-2.5 ^\markup { \small \dynamic "rfz" } -\tweak padding #1 \fermata\arpeggio-\tweak self-alignment-X #0.5 ^\markup { \teeny \italic "L.H." } } \\ { \voiceThree \once \override NoteColumn.force-hshift = #-1 <g,, ais b d g>2.\arpeggio } >>
}

rightTwo = \relative c'''' {
  \ottava #1
  aes8 g f e d cis b ais
  \ottava #0
  aes g f e d cis b ais
  aes g f e d cis b ais
  aes \once \override NoteHead.extra-spacing-width = #'(0 . 5) g s2.
}

left = \relative c, {
  \clef bass
  <ges ges'>4 <ees' ees'> <c' c'> <a' a'>
  <ges' ges'> <ees ees'> <c c'> <a a'>
  <ges ges'> <ees ees'> <c c'> <a a'>
  g8 g' \once \override VoiceFollower.bound-details.left.padding = #3 \once \override VoiceFollower.bound-details.right.padding = #4 \showStaffSwitch \change Staff = "right" \voiceTwo <g' aes b d f >2.\arpeggio
}

\score {
  \new PianoStaff \with { connectArpeggios = ##t } <<
    \new Staff = "right" {
      << \rightOne \\ \rightTwo >>
    }
    \new Staff = "left" {
      \left
    }
  >>
  \midi {
    \tempo 4=180
  }
  \layout { }
}
