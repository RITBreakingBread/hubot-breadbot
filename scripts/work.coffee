# Description:
#   Record time worked on the project.
#
# Configuration:
#
# Commands:
#   hubot worked <hours> <url> <comment> - records hours worked on the given task with a comment attached
#
# Notes:
#   <optional notes required for the script>
#
# Author:
#   craigcabrey

url = 'http://localhost/api/v1/logs'

module.exports = (robot) ->
  robot.respond /worked (\d+.?\d+?) (.*?) (.+)/i, id: 'worked', (msg) ->
    if msg.match[1]? and msg.match[2]? and msg.match[3]?
      data = {
        username: msg.message.user.name,
        real_name: msg.message.user.real_name,
        hours: msg.match[1],
        url: msg.match[2],
        comment: msg.match[3]
      }

      robot.http(url)
        .header('Content-Type', 'application/json')
        .post(JSON.stringify(data)) (err, res, body) ->
          try
            obj = JSON.parse body
            msg.send obj.message
          catch error
            if err or res.statusCode != 200
              msg.send 'failed to record time, womp womp'
            else
              msg.send 'successfully recorded, good job'
    else
      msg.send 'usage: worked [hours] [url] [comment]'
