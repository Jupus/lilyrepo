\version "2.18.2"

\paper {
  indent = 0
  ragged-right = ##f
}

\header {
  tagline = ""
}

#(set-global-staff-size 30)

#(define (pitch-to-color pitch)
        (cond
                ((eqv? (ly:pitch-notename pitch) 0) (x11-color 'gold))
                ((eqv? (ly:pitch-notename pitch) 1) (x11-color 'blue3))
                ((eqv? (ly:pitch-notename pitch) 2) (x11-color 'SaddleBrown))
                ((eqv? (ly:pitch-notename pitch) 3) (x11-color 'purple3))
                ((eqv? (ly:pitch-notename pitch) 4) (x11-color 'DodgerBlue))
                ((eqv? (ly:pitch-notename pitch) 5) (x11-color 'red))
                ((eqv? (ly:pitch-notename pitch) 6) (x11-color 'green3))
        )
)

#(define (color-note grob)
  (pitch-to-color
    (ly:event-property (event-cause grob) 'pitch)))

colours = {
  \override NoteHead.color = #color-note
  \override Stem.color = #color-note
  \override Beam.color = #color-note
  \override Accidental.color = #color-note
  \override Dots.color = #color-note
}

\relative c' {
  \colours
  \omit Score.TimeSignature
  \set Timing.defaultBarType = ""
  \override TextScript.staff-padding = #2
  c4^"C" d^"D" e^"E" f^"F" g^"G" a^"A" b^"B" c^"C"
  \bar "|."
}

\relative c' {
  \colours
  \numericTimeSignature
  \omit Score.BarNumber
  \set Score.markFormatter = #format-mark-box-numbers
  \mark #1
  c4 c c c |
  c2 c |
  d4 d d d |
  d d d2 |
  e4 e e e |
  e2 e |
  f4 f f f |
  f f f2 |
  g4 g g g |
  g2 g |
  a4 a a a |
  a a a2 |
  b4 b b b |
  b2 b |
  c4 c c c |
  c c c2 |
  \bar "|."
}

\relative c' {
  \colours
  \numericTimeSignature
  \set Score.markFormatter = #format-mark-box-numbers
  \mark #2
  c4 e g e |
  c e g2 |
  g4 e c e |
  g1 |
  \bar "|."
}