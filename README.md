# Completorium secundum rubricam pragensem

(Lua)LaTeX sources of a booklet of chanted Compline according to the
medieval diocesan use of Prague.

Main body of the book reproduces the Compline section
of *Diurnale horarum canonicarum secundum veram Rubricam archiepiscopatus Ecclesie Pragensis*
printed 1523 in Nürnberg.
Unlike many others, the 1523 edition treats Compline systematically and
provides many chant and prayer texts (in other sources usually indicated
only by incipits) in full, which is of great help for a modern editor.
Textual variants, alternative rules and additional details
from other print and manuscript sources are provided in footnotes.
Wherever possible, chants are provided with notation sourced
from manuscript sources of the Prague diocesan use, or, if not available,
from manuscripts of other liturgical traditions of the same region
(e.g. Czech Benedictine houses).

Goal of the edition is to make accessible at least a partial experience
of the medieval Divine Office, while not watering down peculiarities
(language, organization) of the original medieval breviary.

## How to use

1. Learn to chant the pre-Vatican II Roman Compline first -
   it's easier to find learning resources and
   it will be much easier to understand and use the medieval book
   with this experience under your belt
1. General structure with default content used for most of the liturgical
   year is at the back of the book, in section *Completorium commune*
1. For common chant tones not included in the book, use,
   for the time being, the "contemporary" Roman tones you learned in step 1.

## Build prerequisites

* Ruby (any version from 2.0 up should work fine)
  * Rake (version shouldn't matter here, either)
  * [gly][gly] - current development version is required
* LaTeX ecosystem - *developed on TeX Live 2025*
  * Gregorio
  * LuaLaTeX
  * [lyluatex][lyluatex] package (should be included in recent TeX Live editions)
  * a few other LaTeX packages - all are pretty standard and included in the TeX Live distribution
* LilyPond 2.24
* *Latin Modern* font family (true type / open type fonts, installed and visible to applications)

## Building

`$ rake`

should produce file `completorium_pragense.pdf`

## Data extraction

If you are only really interested in the chant transcriptions as data,

`$ rake gabc`

produces in directory `cantus/` a bunch of gabc files.
(All the Ruby prerequisites are still needed for this,
but not the LaTeX ones.)

[gly]: https://github.com/igneus/gly
[lyluatex]: https://github.com/jperon/lyluatex
