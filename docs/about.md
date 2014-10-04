OK, let’s fix international numbers **parsing** and **validation** once and forever. I got the inspiration for this in a UI project because somehow the libraries we used didn’t do a great job, so I wrote my own parser, and this is a more polished version of it.

These are the design goals:

* **Simple.** String in, float out, done. ✓
* **Accurate.** Parses numbers and returns `NaN` for non-numbers. (=good for input validation) ✓
* **Lightweight.** (<1k minified) ✓
* **Complete.** No external dependencies ✓
* **Solid.** 100% Code Coverage ✓

In it’s simplest form, you just use it as a `parseFloat` replacement.
