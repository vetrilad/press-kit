fetch:
	ruby scripts/fetch.rb

parse: fetch
	ruby scripts/parse.rb

squash: parse
	ruby scripts/squash.rb

analyze: squash
	ruby scripts/analyze.rb

run: squash
	(python -m SimpleHTTPServer &)
	sleep 1
	(open http://localhost:8000/visualization)
