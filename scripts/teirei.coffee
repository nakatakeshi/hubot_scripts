cron = require('cron').CronJob

module.exports = (robot) ->
    send = (room, msg) -> (new robot.Response(robot, {user : {id : -1, name : room}, text : "none", done : false}, [])).send msg
    job = new cron '00 * * * * *', ->
        console.log "test"
        send "#test-nakatakeshi", "毎分"
    job.start()
