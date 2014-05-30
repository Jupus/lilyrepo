\version "2.17.97"

% set the paper size (try a5, a4, letter, legal etc.)
\paper {
  #(set-paper-size "a4" 'portrait)
  markup-system-spacing.basic-distance = #20
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% A function to position tuplet numbers next to kneed beams on a single
%% staff and between staves. Will ignore tuplets on ordinary beams and
%% with visible brackets.
%%
%% Usage: \override TupletNumber #'Y-offset = #kneed-beam
%%
%% You must use manual beaming for this function to work properly.
%%
%% An additional function, called with a separate override (see below), will
%% horizontally center the tuplet number on the kneed beam.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define (kneed-beam tuplet-number)
   (let* ((tuplet-bracket (ly:grob-object tuplet-number 'bracket))
          (first-note (ly:grob-parent tuplet-number X))
          (first-stem (ly:grob-object first-note 'stem))
          (beam (ly:grob-object first-stem 'beam)))

     (if (and (ly:grob? beam) ; beam on first note?
              (ly:grob-property beam 'knee) ; is it kneed?
              (interval-empty? (ly:grob-property tuplet-bracket 'Y-extent))) ; visible bracket?
         (let* ((stems (ly:grob-object beam 'stems))
                (closest-stem (nearest tuplet-number stems))
                (direction-first-stem (ly:grob-property first-stem 'direction))
                (direction-closest-stem (ly:grob-property closest-stem 'direction))
                (beaming-near-number (car (ly:grob-property closest-stem 'beaming)))
                (beam-multiplier
                 (if (= direction-closest-stem UP)
                     (length (filter positive? beaming-near-number))
                     (length (filter negative? beaming-near-number))))
                (beam-ends (ly:grob-property beam 'positions))
                (mid-beam-Y (/ (+ (car beam-ends) (cdr beam-ends)) 2)) ; mid-beam Y-coordinate
                (number-height (ly:grob::stencil-height tuplet-number))

                ;; inital value of Y-offset (will cause number to overlap beam slightly)
                (correction
                  (- mid-beam-Y
                    (if (= direction-closest-stem UP)
                        (car number-height)
                        (cdr number-height))))
                (beam-width (ly:grob-property beam 'beam-thickness))
                (beam-gap (* 0.5 (ly:grob-property beam 'gap)))
                (beam-padding 0.2)) ; change to move number closer or farther from beam

           ;; refinement of initial value of Y-offset
           (cond
             ((= direction-first-stem direction-closest-stem DOWN)
              (- correction
                (* 0.5 beam-width)
                beam-padding))

             ((= direction-first-stem direction-closest-stem UP)
              (+ correction
                (* 0.5 beam-width)
                beam-padding))

             ((and (= direction-first-stem DOWN) (= direction-closest-stem UP))
              (+ correction
                (* beam-multiplier (+ beam-gap beam-width))
                (* 0.5 beam-width)
                beam-padding))

             ((and (= direction-first-stem UP) (= direction-closest-stem DOWN))
              (- correction
                (* beam-multiplier (+ beam-gap beam-width))
                (* 0.5 beam-width)
                beam-padding)))))))

%% find the stem closest to the tuplet-number
#(define (nearest tuplet-number stems)
  (let* ((refp (ly:grob-system tuplet-number))
         (X-coord (interval-center (ly:grob-extent tuplet-number refp X)))
         (closest (ly:grob-array-ref stems 0)))
    (let lp ((x 1))
     (if (<= (abs (- X-coord
                    (ly:grob-relative-coordinate
                      (ly:grob-array-ref stems x) refp X)))
             (abs (- X-coord
                    (ly:grob-relative-coordinate closest refp X))))
         (set! closest (ly:grob-array-ref stems x)))
     (if (< x (1- (ly:grob-array-length stems)))
         (lp (1+ x))
         closest))))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% A function which horizontally centers a tuplet number on a kneed beam.  May
%% be used in conjunction with the earlier function.
%%
%% Usage: \override TupletNumber #'X-offset = #center-on-beam
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#(define (center-on-beam tuplet-number)
  (let* ((tuplet-bracket (ly:grob-object tuplet-number 'bracket))
         (first-note (ly:grob-parent tuplet-number X))
         (first-stem (ly:grob-object first-note 'stem))
         (beam (ly:grob-object first-stem 'beam)))

    (if (and (ly:grob? beam)
             (ly:grob-property beam 'knee)
             (interval-empty? (ly:grob-property tuplet-bracket 'Y-extent)))
      (let* ((refp (ly:grob-system tuplet-number))
             (number-X (interval-center (ly:grob-extent tuplet-number refp X)))
             (beam-center-X (interval-center (ly:grob-extent beam refp X))))

        (- beam-center-X number-X)))))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% END FUNCTIONS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

kneedTuplet = {
  \once \override TupletNumber #'Y-offset = #kneed-beam
  \once \override TupletNumber #'X-offset = #center-on-beam
}

global = {
   \key f \major
   \time 3/4
   \markLengthOn
}
doubleBar = \bar "||"

manualBeam =
#(define-music-function
  (parser location positions)
  (pair?)
  #{
    \once \override Beam.positions = #positions
  #})

alterBeaming = {
  \overrideTimeSignatureSettings
    7/8		% timeSignatureFraction
    1/8		% baseMomentFraction
    #'(3 2 2)	% beatStructure
    #'()		% beamExceptions
    
  \overrideTimeSignatureSettings
    6/8
    1/8
    #'(3 2 1)
    #'()
    
  \overrideTimeSignatureSettings
    10/8
    1/8
    #'(2 1 2 2 2 1)
    #'()
  
  \overrideTimeSignatureSettings
    2/8
    1/8
    #'(2)
    #'()
}

revertBeaming = {
  \revertTimeSignatureSettings 7/8
  \revertTimeSignatureSettings 6/8
  \revertTimeSignatureSettings 10/8
  \revertTimeSignatureSettings 2/8
}

lh = \markup { \small \italic "L.H" }
rh = \markup { \small \italic "R.H" }


%%%%%%%%%%%%%%%%%%%%%%%%
% RIGHT HAND
%%%%%%%%%%%%%%%%%%%%%%%%

right = \relative c' {
\clef treble \global

%Theme

\override DynamicLineSpanner.staff-padding = #3
\override Score.RehearsalMark.break-visibility = #'#(#t #t #f)

\once \override TextScript #'Y-offset = #4
\tempo "Moderato"
\partial 4 { c4^\markup { \box "Theme" \small \italic "cantabile" }}
f4.-\tweak self-alignment-X #-0.5 \mf e8 f g
a4. e8 f g
a f g a bes4
a2 c,4
f4. e8 f bes
a4. g8 f e
d c b4 d
c2 c4
f4. e8 f g
a4.\< g8 a bes
c\> ees d c bes a\!
g4. des'8 c bes
<< {a2.} \\ {s8 fis ees d \change Staff = left \stemUp c a \change Staff = right} \stemNeutral >>
\mergeDifferentlyHeadedOn
\mergeDifferentlyDottedOn
<< { bes8 d fis a g f } \\ { \once \hide Stem bes,2. } >>
f'2 e4
f2.
\doubleBar

%Var. I

\once \override TextScript #'Y-offset = #4
\tempo "Più mosso"
r4\p^\markup{ \box {"Var. I"} \small \italic "leggiero" } <c f a>8 r <e f a> r
<d f a> r <c f a> r <e f a> r
<d f a> r <c f a> r <des f a> r
<c f a> r <e f a> r <d! f a> r
<c f a> r <e f a> r <d f a> r
<des f a> r <c f a> r <bes f' a> r
<b f' g> r <d f g> r <d g b> r
<c e g> r <d g b> r <e g c> r
r4 <c f a>8 r <e f a> r
<d f a> r <c f a> r <e f a> r
<ees f a> r <ges a> r <f g> r
<g bes> r <g c> r <g bes> r
<d fis a> r <ees fis a> r <cis fis a> r
<d g bes> r <d f! a> r <d g bes> r
<e a> r <d g> r <bes des e> r
\tuplet 10/8 { f'16[ c' f f c' f c f, f c] } f,4
\doubleBar

\mark \markup { \musicglyph #"scripts.ufermata" }

%Var. II

\alterBeaming

\time 7/8
\tempo "Meno mosso"

<f c' f>8\mf^\markup { \box {"Var. II"} \small \italic "marcato" } aes r <f c' f> aes <a e' a> aes
<f c' f> aes r <f c' f> aes <a e' a> aes
<f c' f> aes r <f c' f> aes <a e' a> aes
\time 6/8
<f c' f> aes r <f c' f> aes <a e' a>\noBeam
\time 7/8
<f c' f>8 aes r <f c' f> aes <a e' a> aes
<f c' f> aes r <f c' f> aes <a e' a> aes
<f c' f> aes r <f c' f> aes <a e' a> aes
\time 10/8
<f c' f>\< aes <g d' g> <a e' a> aes <b fis' b> aes <cis gis' cis> aes <dis ais' dis>\!
\time 7/8
<f c' f>\ff aes, r <f' c' f> aes, <a' e' a> aes,
<f' c' f> aes, r <f' c' f> aes, <a' e' a> aes,
<f' c' f> aes, r <f' c' f> aes, <a' e' a> aes,
\time 6/8
<f' c' f> aes, r <f' c' f> aes, <a' e' a>\noBeam
\time 7/8
<f c' f>8 aes, r <f' c' f> aes, <a' e' a> aes,
<f' c' f> aes, r <f' c' f> aes, <a' e' a> aes,
<f' c' f> aes, r <f' c' f> aes, <a' e' a> aes,
\time 2/8
<f' c' f> aes,
\time 7/8
<g d' g> bes? r q bes <b fis' b> bes
\time 6/8
<c g' c> aes r q aes <e' b' e>\noBeam
\time 7/8
<f c' f> aes, r q aes <a' e' a> aes,
<f' c' f> aes, r q aes <a' e' a> aes,
<f' c' f> aes, r q aes <a' e' a> aes,
<f' c' f> aes, <f c' f>4 ~ q4.\fermata

\bar "||"
\revertBeaming
\break

% Var. III

\clef "treble^8"
\time 12/8

\tempo "Allegretto"
\set Timing.beatStructure = #'(3 2 2 2 3)
<<
  \new Voice {
    \oneVoice r8^\markup { \box {"Var. III"} \small \italic "scherzando" }
    \voiceOne
    c''( ees d bes c ees d bes c aes bes)
    \repeat unfold 5 {
      \oneVoice r8
      \voiceOne
      c( ees d bes c ees d bes c aes bes)
    }
    \oneVoice r
    \voiceOne c( e? d bes c e d bes c a? bes)
    \oneVoice r
    \voiceOne c( ees des bes c ees des bes c aes bes)
    \oneVoice r
    \voiceOne c( ees d bes c ees d bes c aes bes)
    \oneVoice r
    \voiceOne c( ees d bes c ees d bes c a? bes)
    \oneVoice r
    \voiceOne c( des bes aes c des bes aes c g aes)
    \once \override TextSpanner.bound-details.left.text = "rit."
    \once \override TextSpanner.bound-details.left.stencil-align-dir-y = #CENTER
    \once \override TextSpanner.direction = #DOWN
    \oneVoice r\startTextSpan
    \voiceOne c( des bes aes c des bes aes c aes g)\stopTextSpan
  }
  \new Voice {
    \voiceTwo
    \repeat unfold 9 {
      s8 f4\p f f f f4.
    }
    s8 fis4 fis fis fis fis4.
    s8 f?4 f f f f4.
    s8 f4 f f f f4.
  }
>>

\autoBeamOff

\tempo "Lento maestoso"

r8 <f c'>\ff <f ees'> <f d'> <f bes> <f c'> <f ees'> <f d'> <f bes> <f c'> <f aes> <f bes>
\repeat unfold 2 {
r8 <f c'> <f ees'> <f d'> <f bes> <f c'> <f ees'> <f d'> <f bes> <f c'> <f aes> <f bes>
}
r8-\tweak staff-padding #4 _\markup { \italic "rit." } <f c'> <f ees'> <f d'> <f bes> <f aes>~ q2.\fermata

\autoBeamOn

\doubleBar
\break

% Var. IV (Coda)


\clef treble
\time 4/4
\key b \major

\tempo "Allegro"

r4\p^\markup { \box "Var. IV" \small \italic "quasi ostinato" } <b, fis'>8 fis <fis cis'> cis <cis gis'> gis
r4 <b' fis'>8 fis <fis cis'> cis <cis gis'> gis
\time 6/4
r4 <b' fis'>8 fis <dis' ais'> gis, <b fis'> fis <fis cis'> cis <cis gis'> gis
\time 4/4
r4 <b' fis'>8 fis <fis cis'> cis <cis gis'> gis
r4 <b' fis'>8 fis <fis cis'> cis <cis gis'> gis
\time 6/4
r4 <b' fis'>8 fis <dis' ais'> gis, <b fis'> fis <fis cis'> cis <cis gis'> gis
\time 4/4

r4 <e'' b'>8 b <b fis'> fis <fis cis'> cis
r4 <e' b'>8 b <b fis'> fis <fis cis'> cis
\time 6/4
r4 <e' b'>8 b <gis' dis'> cis, <e b'> b <b fis'> fis <fis cis'> cis
\time 4/4
r4 <e' b'>8 b <b fis'> fis <fis cis'> cis
r4 <e' b'>8 b <b fis'> fis <fis cis'> cis
\time 6/4
r4 <e' b'>8 b <gis' dis'> cis, <e b'> b <b fis'> fis <fis cis'> cis

r4 <b' fis'>8 fis <fis cis'> cis <cis gis'> gis
r4 <b' fis'>8 fis <fis cis'> cis <cis gis'> gis
\change Staff = "left"
\tuplet 3/2 { bes,[ ees aes-\tweak rotation #'(30 -1.5 0) \<] }
\kneedTuplet
\tuplet 3/2 { des[ \change Staff = "right" fis b\!] } 
\tuplet 3/2 { e-\tweak rotation #'(-30 1 0) -\tweak X-offset #-1 \>[ b fis] }
\tuplet 3/2 { \change Staff = "left" des\![ aes ees] }
\change Staff = "right"

r4 <b'' fis'>8 fis <fis cis'> cis <cis gis'> gis
r4 <b' fis'>8 fis <fis cis'> cis <cis gis'> gis
\change Staff = "left"
\tuplet 3/2 { bes,[ ees aes-\tweak rotation #'(30 -1.5 0) \<] }
\kneedTuplet
\tuplet 3/2 { des[ \change Staff = "right" fis b\!] } 
\tuplet 3/2 { e-\tweak rotation #'(-30 1 0) -\tweak X-offset #-1 \>[ b fis] }
\tuplet 3/2 { \change Staff = "left" des\![ aes ees] }
\change Staff = "right"

r4 <e'' b'>8 b <b fis'> fis <fis cis'> cis
r4 <e' b'>8 b <b fis'> fis <fis cis'> cis
\change Staff = "left"
\tuplet 3/2 { ees,[ aes des-\tweak extra-offset #'(0 . 1) -\tweak rotation #'(30 -1.5 0) \<] }
\kneedTuplet
\tuplet 3/2 { fis[ \change Staff = "right" b e\!] } 
\tuplet 3/2 { a-\tweak rotation #'(-30 1 0) -\tweak X-offset #-1 \>[ e b] }
\tuplet 3/2 { \change Staff = "left" fis\![ des aes] }
\change Staff = "right"

r4 <e'' b'>8 b <b fis'> fis <fis cis'> cis
r4 <e' b'>8 b <b fis'> fis <fis cis'> cis
\change Staff = "left"
\tuplet 3/2 { ees,[ aes des-\tweak extra-offset #'(0 . 1) -\tweak rotation #'(30 -1.5 0) \<] }
\kneedTuplet
\tuplet 3/2 { fis[ \change Staff = "right" b e\!] } 
\tuplet 3/2 { a-\tweak rotation #'(-30 1 0) -\tweak X-offset #-1 \>[ e b] }
\tuplet 3/2 { \change Staff = "left" fis\![ des aes] }
\change Staff = "right"

\bar "||"

\stemUp \tieUp
s2^\markup { \column { \small \italic "attaca" \box "Var. V" } } bes''^\lh
s bes^\lh
s bes^\lh
des^\markup { \small \italic "R.H" } ees^\lh
bes^\rh bes^\lh
s bes^\lh
s2 bes2^\lh
des^\rh ees^\lh
bes-\tweak outside-staff-priority #451 -\tweak extra-offset #'(2.5 . -5) ^\markup { "(Theme)" } ^\markup { \small \italic "sim." } a
bes c
d1~
d2 a
bes c
d bes
c d
ees1
d1~
d
bes2 a
bes ees
d1~
d2 c
bes a
g f
e1
g
f~
f
s1*6

\stemNeutral

\bar "||"

\time 3/2
\key c \major
\clef bass
\tempo "Meno mosso"



r2\f^\markup { \box "Coda" } \tuplet 3/2 2 { r4-\tweak direction #DOWN -\tweak bound-details.left.text "poco accel." -\tweak bound-details.left.stencil-align-dir-y #CENTER \startTextSpan <f,, bes d>-. <e a cis>-. <dis gis bis>-. <d g b>-. <cis fis ais>-.\stopTextSpan }
\numericTimeSignature
\time 2/2
<c! f! a!>8 r b-> <c f a> r b-> r4
r8 q->[ b] r q->[ b] r q->[
b] r q->[ b] r q->[ b] r
q->[ b] r q->[ b] r q->[ b]
r q->[ b] r q->[ b] r q->

\clef treble
r4 << { <bes'' ees aes des>-> } \\ { <f, aes a'!> \oneVoice r4 } >> r8 << { <bes' ees aes des>->~ q } \\ { <f, aes a'>~ q \oneVoice r } >>
s2. \bar "|."
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LEFT HAND
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

left = \relative c, {
\clef bass \global

%Theme

\partial 4 {r4}
f8_\markup { \small \italic "con" \musicglyph #"pedal.Ped" } c' a' f-5 c'-2 a-1
<< { s2 s8 bes~ bes4 a d c a g } \\ { f,8 c' a' g^5 c^2 bes-\tweak self-alignment-X #1 ^1 f, c' a' f d' bes c f, a c, g' c, } >>
f, c' a' f-5 bes-3 d-2
\mergeDifferentlyDottedOn
<< { c4. bes8 a g } \\ { c f, c bes' a g } >>
g, d' a' g fis f
e bes' g e d c
f, c' a' c, f,_5 e_4
d_5 a' f' c bes' d
ees g, c, ees f fis
\mergeDifferentlyHeadedOn
<< { \once \hide Stem g2. } \\ {\stemDown g8 bes c des f4 } >>
d,2.
g,8 a' g fis f d
<< { \once \hide Stem c2. } \\ {\stemDown c8 c' bes e, c' g } >>
a c, f, c f,4
\doubleBar
\mark \markup { \musicglyph #"scripts.ufermata" }

%Var. I

f''8 g f e f g
a g f e f g
a f g a bes c
a f c c c, c'
f g f e f bes
a g f e d c
b d g f e d
\times 2/3 { c c' g } \times 2/3 { c, c g } \times 2/3{ c, g' c }
f g f e f g
a g f g a bes
c d ees f d bes
\change Staff = right g' \change Staff = left f des c bes f
d c' bes a g fis
g fis f e d des
c c' bes a g fis
\tuplet 10/8 { f16[ c f, f c f, c' f f c'] } f4

%Var.I to be finished
%Var.II

\alterBeaming

\time 7/8
<f, c' f>8 <bes' ees> r <f, c' f> <bes' ees> <c,, g' c> <bes'' ees>
<f, c' f> <bes' ees> r <f, c' f> <bes' ees> <c,, g' c> <bes'' ees>
<bes, f' bes> <bes' ees> r <bes, f' bes> <bes' ees> <c,, g' c> <bes'' ees>
\time 6/8
<f, c' f> <bes' ees> r <f, c' f> <bes' ees> <c,, g' c>\noBeam
\time 7/8
<f c' f> <bes' ees> r <f, c' f> <bes' ees> <c,, g' c> <bes'' ees>
<f, c' f> <bes' ees> r <f, c' f> <bes' ees> <c,, g' c> <bes'' ees>
<bes, f' bes> <bes' ees> r <bes, f' bes> <bes' ees> <c,, g' c> <bes'' ees>
<f, c' f> <bes' ees> <dis,, ais' dis> <cis gis' cis> <bes'' ees> \manualBeam #'(1 . 1) <b,, fis' b> \once \stemDown<bes'' ees> \manualBeam #'(0.5 . 0.5) <a,, e' a> \once \stemDown<bes'' ees> <g,, d' g>
\time 7/8
<f c' f>8 \once \stemDown<bes'' ees> r <f,, c' f> \once \stemDown<bes'' ees> <c,,, g' c> \once \stemDown<bes''' ees>
<f,, c' f> \once \stemDown<bes'' ees> r <f,, c' f> \once \stemDown<bes'' ees> <c,,, g' c> \once \stemDown<bes''' ees>
\manualBeam #'(1 . 1)
<bes,, f' bes> \once \stemDown<bes'' ees> r \manualBeam #'(1 . 1) <bes,, f' bes> \once \stemDown<bes'' ees> <c,,, g' c> \once \stemDown<bes''' ees>
\time 6/8
<f,, c' f> \once \stemDown<bes'' ees> r <f,, c' f> \once \stemDown<bes'' ees> <c,,, g' c>\noBeam
\time 7/8
<f c' f> \once \stemDown<bes'' ees> r <f,, c' f> \once \stemDown<bes'' ees> <c,,, g' c> \once \stemDown<bes''' ees>
<f,, c' f> \once \stemDown<bes'' ees> r <f,, c' f> \once \stemDown<bes'' ees> <c,,, g' c> \once \stemDown<bes''' ees>
\manualBeam #'(1 . 1)
<bes,, f' bes> \once \stemDown<bes'' ees> r \manualBeam #'(1 . 1) <bes,, f' bes> \once \stemDown<bes'' ees> <c,,, g' c> \once \stemDown<bes''' ees>
\time 2/8
<f,, c' f> \once \stemDown<bes'' ees>
\time 7/8
<g, d' g> <c' f> r <g, d' g> <c' f> <d,, a' d> <c'' f>
\time 6/8
<c,, g' c> <bes'' ees> r <c,, g' c> <bes'' ees> <g,, d' g>
\time 7/8
<f c' f> \once \stemDown<bes'' ees> r <f,, c' f> \once \stemDown<bes'' ees> <c,,, g' c> \once \stemDown<bes''' ees>
<f,, c' f> \once \stemDown<bes'' ees> r <f,, c' f> \once \stemDown<bes'' ees> <c,,, g' c> \once \stemDown<bes''' ees>
\manualBeam #'(1 . 1)
<bes,, f' bes> \once \stemDown<bes'' ees> r \manualBeam #'(1 . 1) <bes,, f' bes> \once \stemDown<bes'' ees> <c,,, g' c> \once \stemDown<bes''' ees>
<f,, c' f> \once \stemDown<bes'' ees> <f, c' f>4 ~ q4.\fermata

\bar "||"
\revertBeaming

<<
  {
    \clef treble
    \repeat unfold 9 {
      r4. <f'' c'> q q
    }
    r <fis c'> q q
    r <f c'> q q
    r q q q
	
	\autoBeamOff

	r8 <f c'> <f a> <f bes> <f d'> <f c'> <f a> <f bes> <f d'> <f c'> <f e'?> <f d'>
	r <f c'> <f a> <f bes> <f d'> <f c'> <f a> <f bes> <f d'> <f c'> <f e'> <f d'>
	r <f c'> <f a> <f bes> <f d'> <f c'> <f a> <f bes> <f d'> <f c'> <f e'> <f d'>
	r <f c'> <f a> <f bes> <f d'> <f e'>~ q2.\fermata

	\autoBeamOn
  }
  
  \new Staff \with {
    explicitKeySignatureVisibility = #begin-of-line-visible % suppress invisible key signature change on previous line
    } {
    \clef bass
    \key f \major
    <f,, c' f>1.
    q
    <bes f' bes>
    <f c' f>
    <bes f' bes>
    <f c' f>
    <g d' g>
    <c, g' c>
    <f c' f>
    <d a' d>
    <g d' g>
    <c, g' c>
	
	
	<f, c' f c' f>\rfz
	q\rfz
	<bes f' bes f'>\rfz
	<f c' f c' f>\rfz\fermata
	\doubleBar
  }
>>

\time 4/4
\clef bass
\key bes \major

<<
{
s4 bes'' f c
s bes' f c
\time 6/4
s aes'8-\tweak direction #UP \< bes ees4-\tweak direction #UP \> bes f c\!
\time 4/4
s bes' f c
s bes' f c
\time 6/4
s aes'8-\tweak direction #UP \< bes ees4-\tweak direction #UP \> bes f c\!

\time 4/4
s ees' bes f
s ees' bes f
\time 6/4
s des'8-\tweak direction #UP \< ees aes4-\tweak direction #UP \> ees bes f\!
\time 4/4
s ees' bes f
s ees' bes f
\time 6/4
s des'8-\tweak direction #UP \< ees aes4-\tweak direction #UP \> ees bes f\!

s bes f c
s bes' f c
s1
s4 bes' f c
s bes' f c
s1

s4 ees' bes f
s ees' bes f
s1
s4 ees' bes f
s ees' bes f
s1
}
\\
{
\set tieWaitForNote = ##t
bes,,8~ bes'~ <bes, bes'>2.
bes8~ bes'~ <bes, bes'>2.
\time 6/4
bes8~ bes'~ <bes, bes'>4~ <bes bes'>1
\time 4/4
bes8~ bes'~ <bes, bes'>2.
bes8~ bes'~ <bes, bes'>2.
\time 6/4
bes8~ bes'~ <bes, bes'>4~ <bes bes'>1

\time 4/4
ees8~ ees'~ <ees, ees'>2.
ees8~ ees'~ <ees, ees'>2.
\time 6/4
ees8~ ees'~ <ees, ees'>4~ <ees ees'>1
\time 4/4
ees8~ ees'~ <ees, ees'>2.
ees8~ ees'~ <ees, ees'>2.
\time 6/4
ees8~ ees'~ <ees, ees'>4~ <ees ees'>1
\time 4/4
bes8~ bes'~ <bes, bes'>2.
bes8~ bes'~ <bes, bes'>2.
s1
bes8~ bes'~ <bes, bes'>2.
bes8~ bes'~ <bes, bes'>2.
s1

ees8~ ees'~ <ees, ees'>2.
ees8~ ees'~ <ees, ees'>2.
s1
ees8~ ees'~ <ees, ees'>2.
ees8~ ees'~ <ees, ees'>2.
s1
}
>>

<<
  {
    \stemUp bes'8^\rh s4. s2
    bes8^\rh s4. s2
    bes8^\rh s4. s2
    s1*2
    bes8^\rh s4. s2
    bes8^\rh s4. s2
  }
  \\
  {
    \stemNeutral
    \tuplet 3/2 { bes8\p ees aes }
    \kneedTuplet
    \tuplet 3/2 { des[ \change Staff = "right" fis b] }
    \tuplet 3/2 { e b^\markup { \combine \arrow-head #X #LEFT ##t \draw-line #'( 2 . 0 ) \wordwrap \lower #0.5 { \small \italic "melody to the fore" } } fis }
    \change Staff = "left"
    \tuplet 3/2 { des aes ees }
    
    \repeat unfold 27 {
      \stemNeutral
      \tuplet 3/2 { bes8 ees aes }
      \kneedTuplet
      \tuplet 3/2 { des[ \change Staff = "right" fis b] }
      \tuplet 3/2 { e b fis }
      \change Staff = "left"
      \tuplet 3/2 { des aes ees }
    } 
  }
>>

\repeat unfold 3 {
  \tuplet 3/2 { bes8 ees aes }
  \kneedTuplet
  \tuplet 3/2 { des[ \change Staff = "right" fis b] }
  \tuplet 3/2 { e a d }
  \ottava #1
  \tuplet 3/2 { g c f }
  \tuplet 3/2 { bes f c }
  \ottava #0
  \tuplet 3/2 { g d a }
  \tuplet 3/2 { e b fis }
  \change Staff = "left"
  \tuplet 3/2 { des aes ees }
}

\bar "||"

\time 3/2
\key c \major

bes8 r8 r4 \tuplet 3/2 2 { r4 bes-. a-. gis-. g-. fis-. }
\numericTimeSignature
\time 2/2
f8 r c-> r r c-> r4
r4. c8-> r r c-> r
r c-> r r c-> r r c->
\tuplet 3/2 2 { c4 c c c c c c8 c c c c c c c c c c c }
<f, f'>4-> r4 r8 <bes bes'>->~ q r
r <f f'> << { \tuplet 5/2 { <a' a'> r <aes aes'> r <fis fis'> } } \\ { \tuplet 5/2 { r <ees, ees'> r <g g'> r } } >> <f f'>-> r r4 \bar "|."


}

date = #(strftime "%d/%m/%y" (localtime (current-time)))

\header {
  title = "Theme and Variations on the Interval of a Fourth"
  composer = "J. Monks"
  tagline = ""
}

\score {
   \new PianoStaff \with {
		\override StaffGrouper.staff-staff-spacing.basic-distance = #11
	} <<
      \new Staff = right {
         \right
      }
      \new Staff = left {
         \left
      }
      >>
      \midi { }
      \layout { }
}