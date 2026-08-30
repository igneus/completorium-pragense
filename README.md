# Completorium secundum rubricam pragensem

(Lua)LaTeX sources of a booklet of chanted Compline according to the
medieval diocesan use of Prague.

Main body of the book reproduces the Compline section
of *Diurnale horarum canonicarum secundum veram Rubricam archiepiscopatus Ecclesie Pragensis*
printed 1523 in Nürnberg.
Unlike many others, the 1523 edition treats Compline systematically and
provides many chant and prayer texts (in other sources usually indicated
only by incipits) in full, which is of great advantage for a modern editor.
Textual variants, alternative rules and additional details
from other print and manuscript sources are provided in footnotes.
Wherever possible, chants are provided with notation sourced
from manuscript sources of the Prague diocesan use, or, if not available,
from manuscripts of other liturgical traditions of the same region
(e.g. Czech Benedictine houses).

Goal of the edition is to make accessible at least a partial experience
of the medieval Divine Office, while not watering down peculiarities
(language, organization) of the original medieval breviary.

## Prerequisites

* Ruby (any version from 2.0 up should work fine)
  * Rake (version shouldn't matter here, either)
  * [gly][gly] - current development version is required
* LaTeX ecosystem - developed on TeX Live 2025
  * Gregorio
  * LuaLaTeX
  * some (well established and pretty much standard) LaTeX packages

## Building

`$ rake`

[gly]: https://github.com/igneus/gly
