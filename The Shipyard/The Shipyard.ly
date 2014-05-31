\version "2.18.2"

\paper {
  markup-system-spacing.basic-distance = #20
}

triplet = #(define-music-function (parser location tripletMusic) (ly:music?)
             #{
               \tuplet 3/2 { #tripletMusic }
             #})

#(define (make-bend x)
 (make-music 'BendAfterEvent
             'delta-step x))
bend =
#(define-music-function (parser location delta) (integer?)
      (make-bend (* -1 delta)))

bendStart =
#(define-music-function (parser location argument music) (integer? ly:music?)
#{      \hideNotes
        \cadenzaOn
        \once \override NoteHead.extra-spacing-width = #'(0 . 2)
        \once \override NoteHead.X-extent = #'(0 . 0)
        \grace \bend #argument #music \cadenzaOff
        \unHideNotes
#} )


ritard = \markup { \small \italic "ritard." }

\header {
  title = "The Shipyard"
  composer = "Sting"
  arranger = "Michael Healey"
  tagline = ""
}

global = {
  \key f \major
  \numericTimeSignature
  \time 4/4
  \tupletSpan 8
  \set Score.markFormatter = #format-mark-box-letters
  \markLengthOn
  \textLengthOn
  \compressFullBarRests
  \override MultiMeasureRest.expand-limit = #1
}

violin = \relative c'' {
  \global
  % Music follows here.
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/8)
  \set Timing.beatStructure = #'(1 1 1 1 1 1 1 1)
  r2 r4 r8 \triplet { c8( bes16) \bar "||"
  a8( g16) f( a8) } d,8 \triplet { c8( d16) c8( d16) f8( a16) } g8 \triplet { f8( g16)
  f8( g16) a16( bes8) c8( d16) c16( f,) r } \acciaccatura g8( a)[ g] g \triplet { a8( c16)
  d8( c16) a16( g8) } a8 \triplet { a8( g16) f8( g16) a16( c8) } bes8 \triplet { a8( g16)
  f8( g16) a8( bes16) a8(-\tweak avoid-slur #'inside -\tweak staff-padding ##f _\prall g16) a16( bes8) } \acciaccatura bes8( c2)
  \unset Timing.beamExceptions
  \unset Timing.baseMoment
  \unset Timing.beatStructure
  \mark
  \bar "||"
  \tempo \markup { \small \normal-text "Steady 4" }
  s1*0-\tweak outside-staff-priority #1100 ^\markup { \larger \bold "\"Jackie White\"" }
  R1*12
  \tweak self-alignment-X #1 \mark \ritard
  \bar "||"
  s1*0-\tweak self-alignment-X #0 ^\markup { \larger "Chorus 1" }
  R1*4
  a,8([ c) d( f)] f( g16 a) g4
  R1*5
  a8 f c'16( a g f) a8( g) g4
  R1*2
  \repeat unfold 2 {
    f8( aes,) f'( aes,) f'( a,) f'( a,)
  }
  \repeat unfold 2 {
    g'( b,) g'( b,) g'( c,) g'( c,)
  }
  \textLengthOff
  a'( cis,) a'( cis,) a'^\ritard bes c!4\fermata
  \textLengthOn
  s1*0-\tweak extra-offset #'(-2 . -1.8) ^\markup { \italic "slower" }
  R1*2
  \tweak self-alignment-X #1
  \mark \markup { \small \italic "a tempo" }
  \bar "||"
  \textLengthOff
  c,4^\markup { \larger "Chorus 2" } d e f
  <e c'> <f c'> <g c>^\ritard <a c>
  \textLengthOn
  s1*0-\tweak self-alignment-X #0 ^\markup { \italic "slower" }
  R1
  \time 2/4
  \textLengthOff
  s1*0-\tweak self-alignment-X #0 ^\markup { \small \italic "a tempo" }
  R2
  \bar "||"
  \key ees \major
  \tempo \markup { \small \normal-text "country swing" }
  f16 c' ees c d c bes c
  f, c' f bes a f ees c
  f, c' ees c d c bes c
  c ees bes bes~ bes <aes c> <bes ees> <c f>
  f, c' ees c d c bes c
  f, c' f bes a f ees c
  \bendStart #-2 { f, } <bes d>8. c16 bes c d bes
  aes bes g8~ g16 aes g ees
  \once \override Score.RehearsalMark.break-align-symbols = #'(clef)
  \mark \default
  \bar "||"
  \key bes \major
  \markLengthOff
  \tweak self-alignment-X #-0.8
  \tempo \markup { \small \normal-text "a bit slower (deliberate)" }
  s1*0-\tweak self-alignment-X #-0.6 -\tweak outside-staff-priority #1100 ^\markup { \larger \bold "\"Tommy Thompson\"" }
  f4 r
  R2*7
  <c aes'>4 <d bes'>
  <ees c'> <f d'>
  <g ees'> <aes f'>
  <bes g'> <c aes'>
  <c aes'> <d bes'>
  <ees c'>-\tweak self-alignment-X #-0.3 -\tweak staff-padding #4 ^\ritard <d bes'>\fermata
  s1*0-\tweak self-alignment-X #-0.2 ^\markup { \small \italic "colla voce" }
  R2*2
  \bar "||"
  \key aes \major
  \time 4/4
  \tempo \markup { \small \normal-text \italic "pressing on a bit" }
  <c aes'>4 <des aes'> <ees aes> <f aes>
  <g, ees'> <aes ees'> <bes ees>^\ritard <c ees>\fermata
  s1*0-\tweak self-alignment-X #-0.5 ^\markup { \small \italic "a tempo" }
  R1*2
  aes1 aes bes bes
  c2 <aes c>8^\markup { \small \italic "molto rit." } <g des'> <aes ees'>4\fermata
  s1*0-\tweak self-alignment-X #-0.5 ^\markup { \small \italic "a tempo" }
  R1*2
  \mark \default
  \bar "||"
  \key ees \major
  R1*4
  r2 r16 g aes bes~ bes aes g8
  r2 r16 f g aes ~ aes g f8
  \time 3/4 R2.
  \time 4/4
  \repeat unfold 4 {
    <ees ees'>16 <aes aes'> <bes bes'>
  }
  <aes aes'> <g g'> <ees ees'> <des des'>
  <bes bes'>4 r r2
  \repeat unfold 3 {
    <bes bes'>16 <ees ees'> <aes aes'> <ees ees'>
  }
  <bes bes'> <ees ees'> <g g'> <ees ees'>
  s1*0-\tweak self-alignment-X #-0.5 ^\markup { \small \italic "molto rit." }
  R1
  r2^\markup { \small \italic "a tempo" } ees'16 d bes aes bes aes f ees
  \bar "||"
  \key f \major
  f16^\markup { \small \italic { "slight swing" \hspace #1 "50's rock" } } c' ees c d c bes c
  f, c' f bes a f ees c
  f, c' ees c d c bes c
  c ees bes bes~ bes <aes c> <bes ees> <c f>
  f, c' ees c d c bes c
  f, c' f bes a f ees c
  \bendStart #-2 { f, } <bes d>8. c16 bes c d bes
  aes bes g8~ g16 aes g ees
  \markLengthOn
  \mark \default
  \bar "||"
  s1*0-\tweak extra-offset #'(-0.2 . -3) -\tweak self-alignment-X #-1.1 -\tweak staff-padding #2 -\tweak outside-staff-priority #1100 ^\markup { \larger \bold "\"Davey Harrison\"" }
  f4 r r2
  s1*0-\tweak self-alignment-X #-1.5 -\tweak extra-offset #'(0 . 0.7) ^\ritard
  R1*3
  \bar "||"
  \key aes \major
  \once \override Score.MetronomeMark.break-align-symbols = #'(key-signature)
  \tempo \markup { \small \normal-text \italic "a tempo" }
  R1*4
  aes1 bes
  c2 r-\tweak self-alignment-X #0 ^\markup { \small \italic "slower" }
  \bar "||"
  s1*0^\markup { \small \italic "a tempo" }
  ees,4^\markup { \larger "Chorus 3" } f g aes
  <g ees'> <aes ees'> <bes ees> <c ees>
  s1*0-\tweak self-alignment-X #0 ^\markup { \small \italic "slower" }
  R1
  \time 2/4
  R2-\tweak self-alignment-X #0 ^\markup { \small \italic "a tempo" }
  \bar "||"
  \time 4/4
  ees,4-\tweak staff-padding #2 ^\markup { \larger "Chorus 4" } f g aes
  <g ees'> <aes ees'> <aes ees'>8( g) <bes ees>16( aes~ aes8)
  s1*0-\tweak self-alignment-X #0 ^\markup { \small \italic "slower" }
  R1
  <aes, aes'>16 <bes bes'> <c c'> <des des'> <ees ees'> <des des'> <c c'> <bes bes'> <c c'>8 <aes aes'>~ <aes aes'>4\fermata
  \bar "|."
}

\score {
  \new Staff \with {
    instrumentName = \markup { \right-column { "Fiddle" "(Josh)" } }
  } \violin
  \layout { }
}
