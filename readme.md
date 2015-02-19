## NADota Extractor

Haskell script to turn a showthread.php page grabbed from http://www.nadota.com/ into a text file filled with comments.

Expects to be run in a directory with two subdirectors: `html` and `text`. `html` should be filled with .html files, likely retrieved using `wget`.

Requires HandsomeSoup to be installed.

Created for CS410 at UIUC.