fetch:
	ruby fetchers/fetch.rb

parse: fetch
	ruby parsers/parse.rb

squash: parse
	ruby squasher.rb

analyze: squash
	ruby analyzer.rb

run: analyze
	python -m SimpleHTTPServer &; sleep 1; open http://localhost:8000/visualization
