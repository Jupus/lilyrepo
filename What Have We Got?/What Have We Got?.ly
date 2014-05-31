\version "2.18.2"

#(set-global-staff-size 21)

\paper {
  markup-system-spacing.basic-distance = #20
  system-system-spacing.basic-distance = #15
}

triplet = #(define-music-function (parser location tripletMusic) (ly:music?)
             #{
               \tuplet 3/2 { #tripletMusic }
             #})

\header {
  title = "What Have We Got?"
  composer = "Sting"
  arranger = "Michael Healey"
  tagline = ""
}

global = {
  \key f \major
  \numericTimeSignature
  \time 4/4
  \compressFullBarRests
  \override MultiMeasureRest.expand-limit = #1
  \textLengthOn
  \markLengthOn
  \tupletSpan 4
  \override RehearsalMark.break-visibility = #end-of-line-invisible
}

violin = \relative c'' {
  \global
  % Music follows here.
  \tweak self-alignment-X #-1
  \mark \markup { "Intro" }
  s1*0^\markup { "Slowly (Colla Voce)" }
  R1*8
  \tempo "Faster" 4=135
  \repeat unfold 3 {
    a4 \triplet { g8( a g) f a c f c a g( a g) bes a g f a c f c bes }
    a4 \triplet { g8( a g) f a c f c a g( a g) bes a g f a g } f8.\upbow g16\upbow
  }
  a4 \triplet { g8( a g) f a c f c a g( a g) bes a g f a c f c bes }
  a4 \triplet { g8( a g) f a c f c a g( a g) bes( a g) } f4 r
  \key g \major
  \transpose f g' {
    \relative c' {
      a4 \triplet { g8( a g) f a c f c a g( a g) bes a g f a c f c bes }
      a4 \triplet { g8( a g) f a c f c a g( a g) bes a g f a g } f8.\upbow g16\upbow
      a4 \triplet { g8( a g) f a c f c a g( a g) bes a g f a c f c bes }
    }
  }
  d'8.( e16) \triplet { d8 b g } b8.( c16) \triplet { b8 g d } g4 r r2
  \transpose f g' {
    \relative c' {
      a4 \triplet { g8( a g) f a c f c a g( a g) bes a g f a c f c bes }
      a4 \triplet { g8( a g) f a c f c a g( a g) bes a g f a g } f8.\upbow g16\upbow
      a4 \triplet { g8( a g) f a c f c a g( a g) bes a g f a c f c bes }
    }
  }
  d'8.( e16) \triplet { d8 b g } b8.( c16) \triplet { b8 g d } g4 g g r
  \tweak self-alignment-X #-1
  \mark \markup { "Chorus 1" }
  \triplet { \repeat unfold 18 <e a>8 \repeat unfold 6 <e b'> } <e a>4 r r2
  \triplet { \repeat unfold 30 <e a>8 \repeat unfold 6 <e b'> } <e a>4 r r2
  R1
  \tweak self-alignment-X #-1
  \mark \markup { "Verse 3" }
  \bar "||"
  \triplet { <d b'>8 q q } 
  \transpose f g {
    \relative c'' {
      \triplet { g8( a g) f a c f c a g( a g) bes a g f a c f c bes }
      a4 \triplet { g8( a g) f a c f c a g( a g) bes a g f a g } f8.\upbow g16\upbow
      a4 \triplet { g8( a g) f a c f c a g( a g) bes a g f a c f c bes }
    }
  }
  d'8.( e16) \triplet { d8 b g } b8.( c16) \triplet { b8 g d } g4 g g r
  \tweak self-alignment-X #-1
  \mark \markup { "Chorus 2" }
  \triplet { \repeat unfold 18 <e a>8 \repeat unfold 6 <e b'> } <e a>4 r r2
  \triplet { \repeat unfold 30 <e a>8 \repeat unfold 6 <e b'> } <e a>4 r r2
  R1
  \tweak self-alignment-X #-1
  \mark \markup { "Bridge" }
  \bar "||"
  \triplet { \repeat unfold 2 { \repeat unfold 2 { d8 e g b g e } \repeat unfold 2 { d e g b cis b } } }
  \triplet { \repeat unfold 2 { g b d g d b } \repeat unfold 2 { a cis e g a g } }
  \triplet { \repeat unfold 2 { g, b d g d b } g b d g d b } e4 r
  \tweak self-alignment-X #-1
  \mark \markup { "Verse 4" }
  \bar "||"
  \key f \major
  a,4 \triplet { g8( a g) f a c f c a g( a g) bes a g f a c f c bes }
  a4 \triplet { g8( a g) f a c f c a g( a g) bes a g c( d c) bes( a g) }
  a4 \triplet { g8( a g) f a c f c a g( a g) bes a g f a c f c a }
  c8.( d16) \triplet { c8 a f } a8.( bes16) \triplet { a8 f c } f4 r r2
  \tweak self-alignment-X #-1
  \mark \markup { "Verse 5" }
  a4 \triplet { g8( a g) f a c f c a g( a g) bes a g f a c f c bes }
  a4 \triplet { g8( a g) f a c f c a g( a g) bes a g c( d c) bes( a g) }
  a4 \triplet { g8( a g) f a c f c a g( a g) bes a g f a c f c a }
  c8.( d16) \triplet { c8 a f } a8.( bes16) \triplet { a8 f c } f4 g a2
  \tweak self-alignment-X #-1
  \mark \markup { "Chorus 3" }
  \bar "||"
  \transpose g f {
    \relative c' {
      \triplet { \repeat unfold 18 <e a>8 \repeat unfold 6 <e b'> } <e a>4 r r2
      \triplet { \repeat unfold 30 <e a>8 \repeat unfold 6 <e b'> } <e a>4 r r2
      R1
    }
  }
  \tweak self-alignment-X #-1
  \mark \markup { "Final Chorus" }
  \bar "||"
  \key a \major
  \triplet { \repeat unfold 18 <e a>8 \repeat unfold 6 <e b'> } <e a>4 r r2
  <d a'>1 <e b'>
  e'8. fis16 \triplet { e8 cis a } cis8. d16 \triplet { cis8 a e } a4 a a r4 \bar "|."
}

\score {
  \new Staff \with {
    instrumentName = "Fiddle"
  } \violin
  \layout { }
}
