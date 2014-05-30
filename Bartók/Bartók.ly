\version "2.18.2"

extendLV =
#(define-music-function (parser location further) (number?)
#{
  \once \override LaissezVibrerTie.X-extent = #'(0 . 0)
  \once \override LaissezVibrerTie.details.note-head-gap = #(/ further -2)
  \once \override LaissezVibrerTie.extra-offset = #(cons (/ further 2) 0)
#})

move =
#(define-event-function (parser location amount grob)
   (pair? ly:event?)
   #{
     -\tweak extra-offset #amount -$grob
   #})

\header {
  tagline = ""
}

inside =
#(define-event-function (parser location grob)
   (ly:event?)
   #{
     -\tweak avoid-slur #'inside -$grob
   #})

outside =
#(define-event-function (parser location grob)
   (ly:event?)
   #{
     -\tweak avoid-slur #'outside -$grob
   #})

global = {
  \tempo "Rubato." 4=80
  \key c \major
  \time 5/4
}

right = \relative c'' {
  \global
  % Music follows here.
  s1 s4
  s1
  s2 s s s4.
  s4 r8 <fis gis d'! eis!>4-\tweak self-alignment-X #-1 \p-.-- r8 r4 r8 q4-.-- r8 |
  \time 6/8
  \once \hide Score.MetronomeMark \tempo 4.=80
  \once \override TextSpanner.bound-details.left.text = \markup { \smaller \normal-text \bold "Molto sostenuto ed accel. poco a poco il tempo al" }
  r4^\startTextSpan _\pp-\tweak to-barline ##f \< <fis gis eis'>8[-.( r q]-.) r8 |
  r4 <fis gis eis'>8[-.( r q]-.) r8\!\stopTextSpan |
  \tempo "Tempo giusto" 4.=100
  << { \oneVoice r8-\move #'(0 . -1) \p -\tweak after-line-breaking ##t -\move #'(0 . -1)-\tweak to-barline ##f \< \voiceOne s r s r s \time 7/8 \oneVoice r16\! \voiceOne s8 r s r4 s8 \oneVoice r16 } \\ { \slurUp s8 q[(^.-\tweak self-alignment-X #1 ^\markup { \small \italic "capriccioso" } -\move #'(0 . 1.5)-\tweak self-alignment-X #0 _\markup { \small \italic "dolce" } s <a bis gis'>^. s <a dis b'>^.] |
  \time 7/8
  s16 <ais e' bis'>8^.[\>-\tweak self-alignment-X #0 ^\markup { "(" \teeny \note #"16" #UP \italic "sempre =" \teeny \note #"16" #UP ")" } s <gis d' a'>^. s4 <e b' f'>8^.])\! s16 } >> |
  \time 6/8
  r8 <dis ais' fis'>-.([\< r16 <eis b' g'!>8-. r16 <bis' gis'>8-.])\! r8 |
  \time 10/16
  r16 <b, eis g! b>8-.-\tweak positions #'(5 . 5) -\move #'(0 . 0.5) ([\<-\tweak direction #DOWN -\tweak bound-details.left.text \markup { \hspace #3 \small \italic "poco cresc." } \startTextSpan <b' eis g! b>-.\> r <b, eis g b>-.])\! r16 |
  r16 <d ges c d>8-.-\tweak height-limit #5 ([\< \once \override Staff.OttavaBracket.outside-staff-priority = ##f \ottava #1 \set Staff.ottavation = #"8" <d' ges c d>-.\> \ottava #0 r <b,! c e! b'!>-.])\! r16\stopTextSpan |
  <cis a' e'>8-.([-\move #'(0 . -0.5) _\mp r16 <e, a>8-.) r <bis' g' cis>]-.( r16 \break |
  \time 9/16
  <cis a' e'>8[-. r16 <e, a>8-.) r <bis' g'! cis>]-.(
  \time 11/16
  r16 <cis a' e'>8-.[ r <bis g' cis>-. r16 <cis a' e'>8-.]) r16 |
  \time 7/8
  << { \oneVoice r8 s r4 s8 r4-\tweak self-alignment-X #0 -\move #'(0 . -1) _\markup { \small \italic "dim." } } \\ { \slurUp s8 <d! f! cis'>8^.([ s4 <des a' f'>8^.]) } >>
  \time 5/8
  r16 \acciaccatura { ais8 } \stemDown <b, gis' b>-.([ r16 \acciaccatura { e'8 } <f, des' f>-. r \acciaccatura { g'! } <aes, ges' aes>-.] |
  r16 \acciaccatura { ais'8 } <b, gis' b>-.[ r16 \acciaccatura { e'8 } <f, des' f>-. r8 \acciaccatura { g' } <aes, ges' aes>-.] |
  \time 9/16
  r16 \once \override Staff.OttavaBracket.outside-staff-priority = ##f \ottava #1 \set Staff.ottavation = #"8" \acciaccatura { ais'8 } <b, gis' b>-.[^\> r16 \acciaccatura { e'8 } <f, des' f>-.-\tweak self-alignment-X #-0.5 ^\markup { \small \italic "pochissimo rit." } r16 \acciaccatura { g'8 } <aes, aes'>-.])^\ppp \ottava #0 |
  \time 6/8
  r8^\markup { \small \italic "a tempo" } \stemUp <b,,,! aes'>-.([ r r <g' b aes'>-.]) r |
  \stemNeutral
  \time 15/16
  r8 << { \once \omit TupletNumber \tuplet 5/4 { s16 s32 g'16 } s8 } \\ { \set tieWaitForNote = ##t \tuplet 5/4 { \slurUp g,32([ b! aes' \once \tieDown g~ \once \tieUp b!~] } <g b aes'>8) } >> r r <gis, cis a'> r16 r8 |
  \time 6/8
  r-\move #'(0 . -2) _\mp <b d ais'>-.([ r r <d f cis'>-.]) r |
  \time 4/8
  r << { \once \omit TupletNumber \once \omit TupletBracket \tuplet 6/4 { s16 s32 f'16 s } } \\ { \once \omit TupletNumber \once \omit TupletBracket \tuplet 6/4 { \stemUp s16 s b } } \\ { \voiceTwo \set tieWaitForNote = ##t \tuplet 6/4 { \once \slurUp f,32-\tweak height-limit #6 ( b! e \once \override Staff.OttavaBracket.outside-staff-priority = ##f \ottava #1 \set Staff.ottavation = #"8" f~ \once \tieDown b~ \once \tieUp e~ } <f, b e g>8) \ottava #0 } >> r8 |
  \time 10/16
  r <f, b e g!>-.([ r16 <g bes ees fis>8-.-- r16 <g aes ces ees!>8-.--])
}

left = \relative c, {
  \global
  % Music follows here.
  
  \once \omit Score.TimeSignature
  \override Score.StaffGrouper.staff-staff-spacing.basic-distance = #11
  \override LaissezVibrerTie.direction = #DOWN
  \once \override PhrasingSlur.positions = #'(-15 . -2)
  \override Stem.extra-spacing-width = #'(0 . 3)
  \stemUp \extendLV #28 a4\sustainOn^\f-\move #'(3 . -3.5) ^\markup { \small \italic "espr." }\(\laissezVibrer \extendLV #21 cis'-\tweak to-barline ##f -\move #'(0 . -8) ^\<\laissezVibrer \extendLV #14.5 bis'\laissezVibrer \change Staff = "right" \stemDown \extendLV #8.7 fis'\laissezVibrer \extendLV #2.8 gis\laissezVibrer
  \once \omit Score.TimeSignature \time 4/4
  d'!1\!
  \revert Stem.extra-spacing-width
  \once \omit Score.TimeSignature \time 15/8
  
  \stemUp gis,4\) r r2 \change Staff = "left" a,,8-\move #'(-2 . -2) ^\mf\([ cis' \change Staff = "right" \stemDown bis'-\move #'(0 . -1) -\tweak to-barline ##f _\< fis' gis d'! fisis-\tweak self-alignment-X #0 _\markup { \small \italic "dolce" }]
  \noBreak
  
  \once \omit Score.TimeSignature \time 12/8
  eis4\!\)
  \change Staff = "left"
  \stemNeutral
  s1 s4
  \clef treble
  \time 6/8
  a,,,16(_5 cis bis' fis-\tweak avoid-slur #'inside _5 d'! eis) \repeat unfold 2 { a,,16( cis bis' fis d' eis) } a,,16( cis bis' fis d' eis)\sustainOff
  a,,16->(-\move #'(0 . 1) _\markup { \small \italic "sempre leggiero" } -\tweak rotation #'(7 -1 0) \< cis bis' fis d' eis\! dis-\move #'(-1 . 0) _2 -\move #'(0 . 0.8) -\tweak rotation #'(-6 1 0) \> g dis b-\move #'(0 . -1.5) _1 gis f)\!
  \time 7/8
  << { d([ ais' cis fis,]) c([ e b' f]) bes,([-> ees a des, aes-\tweak avoid-slur #'inside ->_5 c_3]) } \\ { s ais'8_2 fis16_3 s e8_3 f16 s ees8_2 des16 } >>
  \time 6/8 g,->(_5 b!\< ais' e bis' dis cis d\! fis_1 d-\move #'(-1.3 . 0.8) -\tweak rotation #'(-3 0 0) \> a f_5)\! |
  \time 10/16
  \mergeDifferentlyDottedOn
  << { gis_1->([ e ais, a' dis,] gis,[ cis fisis c d]) } \\ { s e8.[ dis16_2] s cis8_3[ c16_3 d] } >>
  \clef bass
  << { s16 ces8.[ bes16]-2 s a8[-\move #'(-0.3 . -2) -2 ges16 aes] } \\ { ees'16[( ces f, e' bes] ees,[ a d ges, aes]) } >>
  bes->([\move #'(0 . 3.5)_1 f-\move #'(0 . 1.5) _\< b,! c!-\move #'(0 . 3)_4 d])-\move #'(0 . 3)_1 ees->([_5\! a!_\< d! ges,_3 aes]\! |
  \time 9/16
  bes-^[_\> f\! b,!\< c! d]) ees->([_5\> a!\! d!\< ges,]\! |
  \time 11/16
  bes-^[_1-\tweak rotation #'(4 -1 0) _\< f b,!-\tweak bound-details.left.text \markup { \small \italic "cresc." } -\tweak bound-details.left-broken.text ##f -\tweak bound-details.right.text \markup { \hspace #1 \small \italic "poco" \dynamic "f"  } -\tweak bound-details.right-broken.text ##f \startTextSpan d])-\move #'(0.2 . 1.2) _1 ees([ a! d!]) e,([ f'!\!-\tweak avoid-slur #'outside -^ aes, c!]) |
  \time 7/8
  g([ ees' fis bes,)] a'([-^ c, e\stopTextSpan gis, c e, g b,] ees[ g] |
  \time 5/8
  bes->)([^\mp a des, d] g[ aes ees_\< ges e f])\! |
  bes->([ a des, d] g[ aes-\move #'(3.5 . 0) _\< ees ges e f])\! |
  \time 9/16
  bes->([-\tweak bound-details.left.text \markup { \small \italic "dim." } -\tweak bound-details.left-broken.text ##f -\tweak bound-details.right.text \markup { \hspace #1 \dynamic "p" } -\tweak bound-details.right-broken.text ##f \startTextSpan a des, aes' d, g! ees ges f] |
  \time 6/8
  c->)([\stopTextSpan e! ees' d f, des]) c->([ e ees' d f, des]) |
  \time 15/16
  c->([\< e! bes'_1 ees]_2 ges->[_1\! a,!_2 f des] ees[_4 g b c!_3\< d f bes,]_2\! |
  \time 6/8
  e,!->)-\tweak positions #'(4 . 0) ([_5 gis_3 g'!_1 fis_2 a,!_4 f!])_5 \clef treble g->([_4-\tweak bound-details.right.padding #1 -\tweak staff-padding #4 -\tweak bound-details.left.text \markup { \small \italic "cresc." } -\tweak bound-details.left-broken.text ##f \startTextSpan b_2 bes'_1 a_1 c,!_3 aes]) |
  \time 4/8
  bes->-\tweak positions #'(0 . 1) -\tweak height-limit #5 -\move #'(-0.2 . 0) ([_4 d!_2 aes'_1 des_2] e!^^[_1 ees,_4 g_2 b,]-\inside _5 |
  \time 10/16
  d)([_4\stopTextSpan-\tweak staff-padding #4 -\tweak bound-details.left.text \markup { \small \italic "molto" } -\tweak bound-details.left-broken.text ##f \startTextSpan f!_2 aes-\inside _1 ges_4 bes_2]) b([_1 c_4 f e d])\stopTextSpan |
}

\score {
  \new PianoStaff \with {
    instrumentName = "Piano"
  } <<
    \new Staff = "right" \right
    \new Staff = "left" { \clef bass \left }
  >>
  \midi { }
  \layout { }
}
