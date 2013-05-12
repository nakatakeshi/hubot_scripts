twit = require 'twit'
request = require 'request'
cheerio = require 'cheerio'
exec = require('child_process').exec

t = new twit
    consumer_key : process.env.TWITTER_CONSUMER_KEY,
    consumer_secret : process.env.TWITTER_CONSUMER_SECRET,
    access_token : process.env.TWITTER_ACCESS_TOKEN,
    access_token_secret : process.env.TWITTER_ACCESS_TOKEN_SECRET


module.exports = (robot) ->
    robot.hear /中田/, (msg) ->
        # msg.send "notify to @nakatakeshi"
        t.post 'statuses/update', { status : "@nakatakeshi irc called. #{Date().toString()}"} ,a = (err, reply) ->

    robot.hear /twitter search (.*)/i, (msg) ->
        keyword = encodeURIComponent msg.match[1]
        request = msg.http('http://search.twitter.com/search.json')
            .query(q: keyword)
            .get()
        request (err, res, body) ->
            json = JSON.parse body
            msg.send json.results[0].text if json.results.length > 0

# TODO http://blog.fumiz.me/2012/07/28/node-js-scraping-with-multibyte-characters/
#    robot.hear /(https?:\/\/[-_.!~*\'()a-zA-Z0-9;\/?:\@&=+\$,%#]+)/i, (msg) ->
#        console.log "matched"
#        url = msg.match[1]
#        options =
#            url: url
#            timeout: 2000
#            headers: {'user-agent': 'node title fetcher'}
#
#        request options, (error, response, body) ->
#            console.log error
#            console.log body
#            $ = cheerio.load body
#            title = $('title').text().replace(/\n/g, '')
#            exec "echo \"#{title}\" |nkf -w", {timeout: 1000},
#                (error, stdout, stderr) ->
#                    msg.send(stdout)
