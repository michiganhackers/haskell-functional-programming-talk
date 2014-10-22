haskell-pres.html: haskell-pres.md
	pandoc --self-contained --smart -s -t slidy haskell-pres.md -o haskell-pres.html

clean:
	rm -f haskell-pres.html
