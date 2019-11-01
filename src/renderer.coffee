quickconnect = require 'rtc-quickconnect'
opts =
  room: 'buddy'
  signaller: 'http://ec2-34-244-6-151.eu-west-1.compute.amazonaws.com:8080'
dcs = {}
messages = document.querySelector '.messages'
messageElm = document.querySelector 'input[type=text]'
quickconnect opts.signaller,
  room: opts.room
  plugins: []
.createDataChannel 'events'
.on 'channel:opened:events', (id, _dc) ->
  console.log 'opened events'
  dcs[id] = _dc
  _dc.onmessage = (event) ->
    console.log event
    messages.innerHTML = 'you: ' + event.data + '\n' + messages.innerHTML
module.exports = 
  sendMessage: ->
    message = messageElm.value
    messageElm.value = ''
    messages.innerHTML = 'me: ' + message + '\n' + messages.innerHTML
    for id, dc of dcs
      dc.send message