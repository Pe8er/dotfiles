# Code originally created by the awesome members of Ubersicht community.
# I stole from so many I can't remember who you are, thank you so much everyone!
# Haphazardly adjusted and mangled by Pe8er (https://github.com/Pe8er)

options =
  # Choose color theme.
  verticalPosition    : "bottom"        # top | bottom | center
  horizontalPosition    : "left"        # left | right | center

command: "osascript NextEvent.widget/NextEvent.applescript"

refreshFrequency: '5m'

style: """

  // Specify color palette and blur properties.

  fColor1 = rgba(white,1.0)
  fColor05 = rgba(white,0.5)
  bgColor01 = rgba(black,0)
  blurProperties = blur(16px) brightness(100%) contrast(100%) saturate(150%)

  margin = 0

  if #{options.verticalPosition} == center
    top 50%
    transform translateY(-50%)
  else
    #{options.verticalPosition} margin
  if #{options.horizontalPosition} == center
    left 50%
    transform translateX(-50%)
  else
    #{options.horizontalPosition} margin
    margin-bottom margin

  bottom 24pt*2

  *, *:before, *:after
    box-sizing border-box

  position absolute
  background-color bgColor01

  font-family system, -apple-system, "Helvetica Neue"
  font-size 8pt
  color fColor1
  white-space nowrap

  .wrapper
    padding 6pt
    border-bottom 0.5px fColor05 solid
    display flex
    flex-direction row
    justify-content flex-start
    align-items center
    max-width 64pt*4

  .eventName
    font-weight 700
    margin-left 4pt
    overflow hidden
    text-overflow ellipsis

  .time
    color fColor05

"""

options : options

render: ->

  """
  <div class='wrapper'>
    <div class='time'></div>
    <div class='eventName'></div>
    <!-- <div class='meta'></div> -->
  </div>
  """

# Update the rendered output.
update: (output, domEl) ->

  # Get our main DIV.
  div = $(domEl)

  values = output.slice(0,-1).split("^")

  time = values[0]
  eventName = values[1]
  meta = values[2]

  # Initialize main HTML.
  div.find('.eventName').html(eventName)
  div.find('.time').html(time)
  # div.find('.meta').text(meta)

  if values[0] == ''
    div.animate({opacity: 0}, 250, 'swing').hide(1)
  else
    div.show(1).animate({opacity: 1}, 250, 'swing')

    if @options.verticalPosition is 'center'
      div.css('top', (screen.height - div.height())/2)
    if @options.horizontalPosition is 'center'
      div.css('left', (screen.width - div.width())/2)

    # Sort out flex-box positioning.
    # div.parent('div').css('order', '2')

  # if parseInt(values[2]) != 0
  #   div.find('.meta').show()
  # else
  #   div.find('.meta').hide()
