fetch:
	ruby page_grabber.rb

parse: fetch
	ruby page_parser.rb

squash: parse
	ruby squasher.rb

analyze: squash
	ruby analyzer.rb

run: analyze
	python -m SimpleHTTPServer &; sleep 1; open http://localhost:8000/visualization
