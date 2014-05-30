\version "2.18.2"

#(set-global-staff-size 20)

\paper {
  markup-system-spacing.basic-distance = #20
 
}

\header {
  tagline = ""
  title = "Practical Arrangement"
  composer = "Sting"
  arranger = "arr. Michael Healey"
}

global = {
  \key c \minor
  \time 4/4
  \numericTimeSignature
}

right = \relative c' {
  \global
  \clef treble
  \tupletSpan 4
  \tuplet 3/2 { r8 d ees bes' d, ees d' d, ees } bes'4
  \tuplet 3/2 { r8 d, ees bes' d, ees f' d, ees~ } ees4
  \tuplet 3/2 { r8 d ees bes' d, ees d' d, ees f d ees }
  \tuplet 3/2 { r8 d ees bes' d, ees f' d, ees~ } ees4
  \tuplet 3/2 { r8 d ees bes' d, ees d' d, ees } f4
  \tuplet 3/2 { r8 c ees g bes, ees g g, c } f4
  \tuplet 3/2 { r8 g, aes ees' g, aes } <aes ees'>4 <aes bes d>
  \tuplet 3/2 { r8 g bes d g, bes } << { c4( b) } \\ g2 >>
  \tuplet 3/2 { r8 d' ees bes' d, ees d' d, ees } f4
  \tuplet 3/2 { r8 c ees g bes, ees g g, c } f4
  \tuplet 3/2 { r8 g, aes ees' g, aes } <aes ees'>4 <aes bes d>
  \tuplet 3/2 { r8 g bes d g, bes } << { c4( b) } \\ g2 >>
  \tuplet 3/2 { c8 g ees' c g ees' c g ees' c fis, d' }
  \tuplet 3/2 { bes g d' bes g d' } <fis, bes>4 <f bes>
  \tuplet 3/2 { aes8 f c' aes f c' } <f, aes c>4 <f bes d>
  <bes d g>2 << d \\ { <g, c>4 b } >>
  <c ees> <ees g> <bes d ees> <d ees g>
  <g, b> <b ees> << { bes'~ \tuplet 3/2 { bes8 bes' f } \time 2/4 <bes, g'>2 } \\ { <aes, ees'>2~ \time 2/4 <aes ees'> } >>
  \time 4/4
  << { s2 <c' f aes c>2\arpeggio } \\ { <f,, c' f>1 } >>
  <c' d g>2 <b d>
  \tuplet 3/2 { r8 c g' c c, g' c c, g' c c, g'~ }
  \tuplet 3/2 { g c, g' c c, g' c c, g' } c4
  <aes, c e g>2 <b ees f aes>
  << { \tuplet 3/2 { <d ees g>8 f bes } } \\ { bes,4 } >> g'4~ g8 ees \tuplet 3/2 { bes ees4 }
  \key bes \minor
  << { \tuplet 3/2 { ees8 des ges } ees4 } \\ { ces2 } >> <des ees aes>
  \tuplet 3/2 { r8 c des aes' c, des aes' c, des aes' c, des }
  \tuplet 3/2 { r8 bes des aes' bes, des aes' aes, des } ges,4
  <ges bes>2 <bes des>4 <aes c>
  <c f aes>2 << c \\ { bes4( a) } >>
  \tuplet 3/2 { r8 c des aes' c, des c' c, des~ } des4
  \tuplet 3/2 { r8 bes des f aes, des f ges, bes~ } bes4
  r4 <ees, ges bes> <ges bes des> <aes c>
  <c f>2 << c \\ { bes4( a) } >>
  \tuplet 3/2 { bes8 f des' bes f des' bes f des' bes e, c' }
  \tuplet 3/2 { aes f c' aes f c' } <e, aes>4 <ees aes>
  <ges bes>2 <ges bes des>4 <ges aes c>
  <f c' f>2 << c' \\ { bes4( a) } >>
  <c des f> q <bes des f> q
  <a des f> <bes des f> << { s4 \tuplet 3/2 { r8 aes'' f } } \\ <ges,, des' aes'!>2 >>
  \time 2/4
  <ges' aes des>2
  \time 4/4
  << { s2 \arpeggioArrowDown <des' des' ges>\arpeggio } \\ { <ees, \tweak NoteHead.extra-spacing-width #'(0 . 3) bes'>1 } >>
  <bes c f>4 q <a c f> q
  \tuplet 3/2 { r8 bes f' bes bes, f' bes bes, f' bes bes, f' }
  \tuplet 3/2 { r8 bes, f' bes bes, f' bes bes, f' bes bes, f' }
  << { <d f>4 <ees ges> } \\ bes2 >> <des ees aes>
  \tuplet 3/2 { <c des f>8 ees aes } f4~ \tuplet 3/2 { f c8~ c des ees }
  << { \tuplet 3/2 { ees des ges } ees4 } \\ ces2 >> <c e ges b>4 q
  \key cis \minor
  <dis e gis b> q q q
  <b cis e gis> q q q
  <a e' b'> q <e' a dis> <dis b'>
  <b dis e gis> q << { cis( bis) } \\ gis2 >>
  <dis' e gis b>4 q q q
  <cis e gis cis> q q q
  <a e' b'> q <cis e gis> <b dis fis>
  <gis dis' gis> \tuplet 3/2 { <gis dis'> e8 } <fis cis'>4 <fis bis>
  \tuplet 3/2 { cis'8 gis e' cis gis e' cis gis e' cis fisis, dis' }
  <gis, b>4 q <fisis b> <fis b>
  <a cis e> q q <b dis fis>
  <b dis e gis> q <gis cis> <gis bis>
  <gis cis e> q <gis dis' e> q
  <gis bis e> <gis cis e> << { s4 \tuplet 3/2 4 { r8 e''' b \time 2/4 e, b a~ } a4 } \\ { <a, e' b'>2~ \time 2/4 q } >>
  \time 4/4
  << { s2 \arpeggioArrowDown <e' cis' fis>2\arpeggio } \\ <fis, cis' \tweak NoteHead.extra-spacing-width #'(0 . 2) fis>1 >>
  <cis' dis gis>2 <bis dis>
  \tuplet 3/2 { r8 cis gis' cis cis, gis' dis' cis, gis' e' cis, gis' }
  \tuplet 3/2 { r8 cis, gis' cis cis, gis' dis' cis, gis' e' cis, gis' }
  << { <cis, eis gis>4 fis } \\ a,2 >> <bis disis gis aisis>
  <a cis e gis>4 q q q
  <gis cis e> q <gis dis' e> q
  \time 2/4
  <gis bis e> <gis cis e>
  \time 4/4
  << { r8 b16 fis' \stemDown b dis fis b \ottava #1 dis fis b dis fis4 \ottava #0 } \\ <\tweak NoteHead.extra-spacing-width #'(0 . 4) e,,, b'>1 >>
  <a, cis dis gis>2 <bis disis fis aisis>\fermata
  \tuplet 3/2 { \set tieWaitForNote = ##t \tieUp r8 dis~ cis~ gis~ dis~ \tieDown cis~ } <dis' cis gis dis cis>2\fermata \bar "|."
}

left = \relative c {
  \global
  \clef bass
  g'1
  g
  g
  g
  g
  aes,
  f2 bes
  ees, g
  g'1
  aes,
  f2 bes
  ees, g
  c d
  g, g
  <f ees'> bes
  ees, g
  c bes
  a
  f~
  \time 2/4
  f
  \time 4/4
  des1
  << { g'4 g } \\ g,2 >> <g d'>
  aes1
  f
  <d d'>2 g
  <c, c'>1
  \key bes \minor
  <aes' ges'>2 <f a'>
  bes1
  ges
  <ees ees'>2 << { ges'4 ges } \\ aes,2 >>
  <des, des'> f
  bes1
  ges
  ees2 aes
  <des, des'> f
  bes c
  f,1
  <ees ees'>2 aes
  <des, des'> f
  bes aes
  g <ees bes'>~
  \time 2/4
  q
  \time 4/4
  <ces' bes'>1
  f,
  ges
  ees
  <c' ges'>2 <f, a'>
  <bes aes'>1
  <aes ges'>2 q
  \key cis \minor
  <cis, cis'>1
  a'
  <fis e'>2 <b a'>
  <e, e'> <gis fis'>
  <cis, cis'>1
  <a' a'>
  <fis e'>2 <b a'>
  <e, e'> gis4 gis
  <cis, cis'>2 <dis dis'>
  gis gis4 gis
  <fis e'>2 b
  <e, e'> <gis fis'>4 q
  cis2 b
  ais <fis cis'>~
  \time 2/4
  q
  \time 4/4
  <d d'>1
  << { r4 gis' gis gis } \\ gis,1 >>
  << { r2 b'4 a } \\ a,1 >>
  << { r2 b'4 a } \\ fis,1 >>
  <dis dis'>2 <gis fis'>
  <fis e'>1
  <cis cis'>2 b'
  \time 2/4
  ais
  \time 4/4
  <fis cis' a'>1
  <dis cis'>2 gis
  r2 cis,2 \bar "|."
}

\score {
  \new PianoStaff \with { instrumentName = "Piano" } <<
    \new Staff = "right" {
      \right
    }
    \new Staff = "left" {
      \left
    }
  >>
}