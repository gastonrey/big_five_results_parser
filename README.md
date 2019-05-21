# Big Five Test Serializer

This repo containes a serializer for output text result from Short Big Five test results (see sample file `test_result.txt`)

# How to use

Create an instance as follow:

`serializer = BigFiveResultsTextSerializer.new(txt_result)`
`serializer.to_h` This will return a hash with all the contained tables at the txt file just parsed.

To post resuls just run:

`ruby bin/post_results.rb` This is the ruby script that parse, post and output results.

# Notes

At `/helpers` you will find the parser helper an corresponding regex used to obtain the name and tables from the txt file.
Folder `/services` contains a poster class that given an email and a hash publishes (POST) the results to an endpoint.
the `/config` folder contains the aprameters used to post the results, these are `email` and `url`
