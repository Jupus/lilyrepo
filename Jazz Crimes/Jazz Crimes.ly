\version "2.18.2"

\include "../Includes/LilyJAZZ.ily"
\include "../Includes/scoop.ily"
\include "../Includes/zigzag.ily"

\paper {
  page-count = #1
  indent = #15
  ragged-last-bottom = ##f
  score-system-spacing.basic-distance = #5
  markup-system-spacing.basic-distance = #20
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
  \numericTimeSignature
  \override ChordNames.ChordName.font-name = #"LilyJAZZText"
  \accidentalStyle modern-cautionary
  \jazzOn
}

ossiaSettings = \with {
  \global
  alignBelowContext = #"sax"
  \omit TimeSignature
  \omit KeySignature
  firstClef = ##f
  fontSize = #-1
  \override StaffSymbol.staff-space = #(magstep -1)
}

altoSax = \relative c' {
  \global
  % Music follows here.
  \repeat volta 2 {    
    r8 fis16 e fis8[ r16 c16] e a fis8 r fis16 d |
    r fis cis fis g[ r8 c,16] r16 des ees ces' d,8 c16 a |
    b e fis8 r16 f[ r e] r g aes ges ees8 d16 c |
    g' fis b,8 a g16 b bes d des f e g a e |
    r8 fis16 e bes'8[ r16 aes] g c des8 r c16 aes |
    r g d' b ees8[ r16 e] r cis fis b, a8 aes16 ges |
  }
  \alternative {
    {
      b cis d8 r16 e[ r f] r fis g c, b8 a16 g |
      d' c fis,8 e d16 fis f a aes c b d e g, |
    }
    {
      b cis d8 r16 e[ r f] r fis g c, b8 a16 g |
    }
  }
  d' c fis,8 e d16 fis f a aes c b d aes g
  \break
  fis2 r8 fis fis e16 fis~ |
  fis2 r8 fis fis f16 fis~ |
  fis4. f8~ f4 f16[ fis r g] |
  aes2 r16 g aes g \once \override Beam.positions = #'(-2 . -2) a \once \override NoteHead.extra-spacing-width = #'(0 . 1) b \scoop g8 |
  fis2 <<
    { r8 a b16 a fis e }
    \new Staff \with {
      \ossiaSettings
    }
    {
      \override TextScript.extra-offset = #'(-13 . 3.75)
      \key fis \minor \slashedGrace { c'16( } cis8)-\markup { "2nd time" } b a16 fis e cis
    }
  >> |
  fis2 r8 fis fis g16 gis~ |
  gis4. g8~ g4 g16[ gis r a] |
  bes2 << { r8 aes16 f d b \times 2/3 { aes f d } }
          \new Staff \with {
            \ossiaSettings
          }
          {
            \key fis \minor r8 bes''16 ges \once \override Beam.positions = #'(0 . -1) ces des \scoop beses8
          }
  >> |
  \override Score.RehearsalMark.break-visibility = #end-of-line-visible
  \override Score.RehearsalMark.self-alignment-X = #1
  \mark \markup { \override #'(box-padding . 0.5) \box "D. C." }
  \break
  fis2^\markup { "chords sim." } r8 a c32 cis c a fis16 e |
  fis2 r8 fis fis f16 fis~ |
  fis4. f8~ f4 f16[ fis r g] |
  aes2 r16 g aes g a b g8 |
  fis2 fis'8 e16 cis b a fis e |
  fis2 r8 fis fis g16 gis~ |
  gis4. g8~ g4 g16[ gis r a] |
  bes4 r8 b ~ b a16 b fis8 e |
  r8 fis' ~ fis2. \zigzagTear
}

chExceptionMusic = {
  <c f g bes d'>-\markup { \super { "9" \hspace #0.3 "sus" } }
  <c e g bes des' ees' fis' aes'>1-\markup { \super { "7" \hspace #0.3 "alt" } }
}

chExceptions = #( append
  ( sequential-music-to-chord-exceptions chExceptionMusic #t)
  ignatzekExceptions)

chordmusic = \chordmode {
  \global
  \set chordNameExceptions = #chExceptions
  s8 fis:13.11 s4 a8:13.11 s4 bes8:7.5+ |
  s4 ees4:7.9+ s8 e:9 ees4:7.9+ |
  s8 c:7.5- s4 b8:maj7 s4 d8.:9
  g:maj7 s4 s16 gis8.:m7 s16 cis8.:7.9-.10-.11+.13- |
  s8 fis:11.13 s4 a8:11.13 s4 bes8:7.5+ |
  s4 ees:7.9+ s8 e:9 ees4:7.9+ |
  s8 c:7.5- s4 b8:maj7 s4 d8.:9
  g:maj7 s4 s16 gis8.:m7 s16 cis8.:7.9-.10-.11+.13- |
  s8 c:7.5- s4 b8:maj7 s4 d8.:9
  g:maj7 s4 s16 gis8.:m7 s16 cis8.:7.9-.10-.11+.13- |
  e4.:m7 a8:11.13 s2 |
  dis4.:m7 gis8:11.13 s2 |
  f4.:m7.5- b8:7 s2 |
  fis4.:m7 b8:7 s2 |
  e4.:m7 a8:11.13 s2 |
  dis4.:m7 gis8:11.13 s2 |
  e4./f dis8:7/ais s2 |
  gis4.:9sus4 cis8:7.9-.10-.11+.13- s2 |  
}

\score {
  <<
    \new ChordNames { \chordmusic }
    
    \new Staff = "sax" \with {
      instrumentName = "Alto Sax"
      \override InstrumentName.padding = #2
      extraNatural = ##f
      \override VerticalAxisGroup.default-staff-staff-spacing =
      #'((basic-distance . 6)
         (padding . 0))
    } 
    \transpose ees c'
    { \altoSax }
  >>
  \layout {
    \context {
      \Staff
      fontSize = #-1
      \override StaffSymbol.staff-space = #(magstep -1)
    }
    \context {
      \Score
      \consists "Span_bar_engraver"
    }
  }
}

rhythmOne = {
  \global
  r8 b r4 b8 r4 b8 |
  r4 b r8 b b4 |
  r8 b r4 b8 r4 b8~ |
  b16 b8. r4 r16 b8. r16 b8. \override SpanBar.allow-span-bar = ##t \bar ":|]" |
}

rhythmTwo = {
  \global
  \repeat unfold 4 {
    b4. b8~ b2 |
  }
}

\score {
  \new StaffGroup <<
  \new RhythmicStaff \with { instrumentName = \markup { \center-column { \line { "Rhythm 1" } \line { "(bars 1-10)" } } } \override VerticalAxisGroup.default-staff-staff-spacing.basic-distance = #5 }
  {
    \rhythmOne
  }
  \new RhythmicStaff \with { instrumentName = \markup { \center-column { \line { "Rhythm 2" } \line { "(bars 11-18)" } } } }
  {
    \rhythmTwo
  }
  >>
  \layout {
    \context {
      \RhythmicStaff
      fontSize = #-2
      \override StaffSymbol.staff-space = #(magstep -2)
    }
    \context {
      \StaffGroup
      \remove "System_start_delimiter_engraver"
      \remove "Span_bar_engraver"
    }
    \context {
      \Score
      \override SystemStartBar.collapse-height = #13
    }
  }
}
