Client = require('node-rest-client').Client;
prompt = require 'prompt'


console.log 'Enter one of the following command'
console.log 'get 10 100 - to get 10th page with 100 numbers'
console.log 'fav 100    - to mark 100th number as favorite '


prompt.start()
prompt.get 'command', (err, res) ->
  onErr err if err
  client = new Client();
  getRes = res.command.match /^get (\d+) (\d+)$/
  if getRes
    options =
      data:
        page: getRes[1]
        amount: getRes[2]
      headers:
        'Content-Type': "application/json"
    client.get 'http://127.0.0.1:3000/', options, (data) ->
      console.log data
    return
  favRes = res.command.match /^fav (\d+)$/
  if favRes
    number = favRes[1]
    client.put "http://127.0.0.1:3000/favorite/#{number}", (data) ->
      console.log data
    return
  console.log 'Wrong command'

onErr = (err) ->
  console.log err
  1
