fetch:
	ruby scripts/fetch.rb

parse: fetch
	ruby scripts/parse.rb

analyze: parse
	ruby scripts/analyze.rb

run: analyze
	(python -m SimpleHTTPServer &)
	sleep 1
	(open http://localhost:8000/visualization)

console:
	ruby -e "require('./main.rb');binding.pry"
