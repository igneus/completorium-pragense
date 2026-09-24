\version "2.24.0"

% stylesheet
%   chant notation with mensural features
%   styled to fit (as far as possible) in the Gregorio-dominated book
#(set-global-staff-size 25)

\paper {
  #(define fonts
     (make-pango-font-tree
      "Latin Modern Roman"
      "Latin Modern Sans"
      "Latin Modern Mono"
      (/ 19 20)))

  % annotate-spacing = ##t
}

\layout {
  \context {
    \Score

    \remove "Bar_number_engraver"
  }

  \context {
    \Staff

    \override StaffSymbol.line-count = #4
    \override StaffSymbol.thickness = #0.6

    \override Clef.extra-offset = #'(-0.8 . 0)
    \override Clef.font-size = #2.4
    \override Clef.space-alist.first-note = #'(minimum-fixed-space . 0.5)

    \override Custos.style = #'vaticana
    \override Custos.extra-offset = #'(0.1 . 0)
    \override Custos.font-size = #3

    \override NoteHead.style = #'blackpetrucci
    \override NoteHead.font-size = #-1.5

    \override Stem.length = #4

    \override BarLine.hair-thickness = #1.0
    \override BarLine.gap = #2 % seems to have no effect for \bar "||"

    \consists "Custos_engraver"

    \remove "Time_signature_engraver"
  }

  \context {
    \Lyrics

    \override LyricHyphen.thickness = #1.1
  }
}

#(define-markup-command (fake-initial layout props initial first-annotation second-annotation) (string? string? string?)
   "Builds an initial markup with two annotation lines"
   (interpret-markup layout props
                     #{
                       \markup{
                         \override #'(baseline-skip . 1.5)
                         \center-column{
                         \tiny #first-annotation
                         \small #second-annotation
                         \vspace #0.2
                         \override #'(font-size . 9) #initial
                       }
                       }
                     #} ))
% /stylesheet

\score {
  <<
    \new Voice = "v" \relative c' {
      \set Staff.instrumentName = \markup\fake-initial "C" "Hymnus" "III"


      \clef "vaticana-do3"
      \stemUp
      \cadenzaOn

      c1 c b g a a f e
      g g e c g' f2 g a1
      \break
      c c b g a a2 a f1 e
      g g e c g' f2*1/8\melisma g2\melismaEnd a1
      \break
      a a e f d c d1*1/8\melisma f1\melismaEnd f % TODO ligature
      f f e d e f g
      \break
      a a f e d f e \bar "||"
    }
    \new Lyrics \lyricsto "v" {
      or -- de na -- tus ex Pa -- ren -- tis
      an -- te mun -- di ex -- or -- di -- um
      Al -- pha et O cog -- no -- mi -- na -- tus
      ip -- se fons et clau -- su -- la
      om -- ni -- um quae sunt fu -- e -- runt
      quae -- que post fu -- tu -- ra sunt
      sae -- cu -- lo -- rum sae -- cu -- lis.
    }
  >>
  \layout {

    \context {
      \Score
      \override SpacingSpanner.common-shortest-duration = #(ly:make-moment 1/1)
    }
    \context {
      \Staff

      % manually align the fake initial with lyrics baseline
      \override InstrumentName.extra-offset = #'(0 . -1.4)
    }
    \context {
      \Lyrics
      \override VerticalAxisGroup.nonstaff-relatedstaff-spacing = #'((basic-distance . 1) (padding . 0.8))
    }

    ragged-last = ##t
    indent = 0.6\in
  }
  \header {
    id = "cordenatus_specialnik"
    office-part = "hymnus"
    manuscript = "CZ-HKm Hr-7, 292r"
    cantus-id = "008289"
    mode = "3"
    firstannotation = "Hymnus"
    secondannotation = "III"
  }
}
