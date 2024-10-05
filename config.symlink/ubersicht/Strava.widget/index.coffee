# Code originally created by the awesome members of Ubersicht community.
# I stole from so many I can't remember who you are, thank you so much everyone!
# Haphazardly adjusted and mangled by Pe8er (https://github.com/Pe8er)

options =
  # Easily enable or disable the widget.
  widgetEnable    :         true
  # Your Strava user ID. It's at the end of your profile page URL.
  myid            :         "7217285"
  # Your Strava authorization token. Get one here - www.strava.com/settings/api.
  token           :         "545a5f91ea156a7a415f8ea985c277a2808f5caf"
  # Distance units: KM for kilometers or M for miles.
  units           :         "KM"
  # Your yearly biking goal in kilometers.
  yearlygoal      :         "4000"
  # When do you want to meet your goal? If it's empty, it will set the date to the last day of current year. Use "MM/DD/YY" format.
  deadline      :         "12/12/16"
  # Stick the widget in the bottom right corner? Set to *true* if you're using it with Sidebar widget, set to *false* if you'd like to give it some breathing room and a drop shadow.
  stickInCorner   :         true

refreshFrequency:         '1h'

command: "osascript Strava.widget/Strava.applescript #{options.myid} #{options.token} #{options.units} #{options.yearlygoal} #{options.deadline}"

style: """

  // A few useful variables.

  fColor1 = rgba(white,1)
  fColor05 = rgba(white,0.5)
  fColor02 = rgba(white,0.2)
  bColor1 = rgba(black,1)
  bColor05 = rgba(black,0.5)
  bColor02 = rgba(black,0.2)

  if #{options.stickInCorner} == false
    margin = 20px
    box-shadow 0 20px 50px 10px rgba(0,0,0,.6)
  else
    margin = 0

  transform-style preserve-3d
  bottom margin
  right margin
  width 176px
  overflow hidden
  white-space nowrap
  position relative
  -webkit-backdrop-filter: blur(30px) brightness(80%) contrast(100%) saturate(140%);
  background-color bColor02
  font-family system, -apple-system
  opacity 0
  display none

  *, *:before, *:after
    box-sizing border-box

  .wrapper
    font-size 8pt
    line-height 11pt
    color fColor1
    padding 8px
    height auto

  .week, .year
    width 100%
    margin-bottom 4px

  .left
    opacity 0.5
    float left

  .wDistance, .yDistance
    display block
    margin 0 0 0 auto
    font-weight 700
    text-align right

  .bars
    margin 4px 0 8px 0
    height 8px
    position relative

  .bar, .progress, .goal
    top 0
    left 0
    background-color fColor02
    height 8px
    width 100%
    max-width 100%
    min-width 1%
    z-index 1
    position absolute

  .goal
    background-color fColor02
    z-index 2
    width 2%

  .progress
    background-color fColor1
    z-index 3
    width 1%

  .outdone
    background none
    height 10px
    border-right 1px solid fColor05
"""

options : options

render: (output) ->
  # Initialize our HTML.
  stravaHTML = ''

  # Create the DIVs for each piece of data.
  stravaHTML = "
    <div class='wrapper'>
      <div class='week'>
        <span class='left'>Week</span>
        <span class='wDistance'>No Data</span>
        <div class='bars'>
          <div class='bar'></div>
          <div class='bar progress'></div>
          <div class='bar goal'></div>
        </div>
      </div>
      <div class='year'>
        <span class='left'>Year</span>
        <span class='yDistance'>No Data</span>
        <div class='bars'>
          <div class='bar'></div>
          <div class='bar progress'></div>
          <div class='bar goal'></div>
        </div>
      </div>
     </div>"
  return stravaHTML

# Update the rendered output.
update: (output, domEl) ->

  # Get our main DIV.
  div = $(domEl)

  if @options.widgetEnable

    # Get our pieces.
    values = output.slice(0,-1).split("~")

    # Initialize our HTML.
    stravaHTML = ''

    if values[0] != "NA"

      # Define variables
      wDistance = values[0]
      wProgress = values[1]
      wGoal = values[2]
      yDistance = values[3]
      yProgress = values[4]
      yGoal = values[5]

      # Update text values
      div.find('.wDistance').html(wDistance)
      div.find('.yDistance').html(yDistance)

      # Update bar widths
      div.find('.week .progress').css('width', wProgress)
      div.find('.week .goal').css('width', wGoal)
      div.find('.year .progress').css('width', yProgress)
      div.find('.year .goal').css('width', yGoal)
      if parseInt(yGoal) < parseInt(yProgress)
        div.find('.year .goal').addClass('outdone')
      if parseInt(wGoal) < parseInt(wProgress)
        div.find('.week .goal').addClass('outdone')

      # Show the damn thing!
      div.css('display', 'block')
      div.animate {opacity: 1}, 250, 'swing'
    else
      div.css('display', 'none')
      div.animate {opacity: 0}, 250, 'swing'

    # Sort out flex-box positioning.
    div.parent('div').css('order', '2')
    div.parent('div').css('flex', '0 1 auto')
  else
    div.remove()
