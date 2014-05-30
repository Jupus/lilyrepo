\version "2.18.2"

rH = \tweak extra-offset #'(0.5 . 0) \rightHandFinger \markup \concat {
    \override #'(thickness . 2)\draw-line #'(0 . 3)
    \hspace #-.2
    \override #'(thickness . 2)\draw-line #'(1 . 0)
}

lH = \tweak extra-offset #'(0.5 . 0) \rightHandFinger \markup \concat {
  \override #'(thickness . 2) \draw-line #'(0 . -3)
  \hspace #-.2
  \override #'(thickness . 2) \draw-line #'(1 . 0)
}