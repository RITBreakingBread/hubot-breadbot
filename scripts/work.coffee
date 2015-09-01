url = 'http://localhost/api/v1/logs'

module.exports = (robot) ->
  robot.respond /worked ?(\d+)? ?(.+)?/i, (msg) ->
    if msg.match[1]? and msg.match[2]?
      data = {'username': msg.message.user.name, 'real_name': msg.message.user.real_name, 'hours': msg.match[1], 'comment': msg.match[2]}
      msg.http(url)
        .post(data) (err, res, body) ->
          if err or res.statusCode != 200
            msg.send 'failed to record time, womp womp'
          else
            msg.send 'successfully recorded, good job'
    else
      msg.send 'usage: worked [hours] [comment]'
