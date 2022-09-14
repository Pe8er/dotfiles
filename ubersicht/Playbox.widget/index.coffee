# Code originally created by the awesome members of Ubersicht community.
# I stole from so many I can't remember who you are, thank you so much everyone!
# Haphazardly adjusted and mangled by Pe8er (https://github.com/Pe8er)

options =
  # Choose where the widget should sit on your screen.
  verticalPosition    : "bottom"        # top | center | bottom
  horizontalPosition    : "left"        # left | center | right

  # Choose widget size.
  widgetSize: "smol"                  # big | medium | smol

  # Choose color theme.
  widgetTheme: "dark"                   # dark | light

command: "osascript 'Playbox.widget/lib/getCurrentSong.applescript'"
refreshFrequency: '1s'

style: """

  // Let's do theming first.

  if #{options.widgetTheme} == dark
    fColor = white
    bgColor = black
    bgBrightness = 80%
    bgContrast = 100%
  else
    fColor = black
    bgColor = white
    bgBrightness = 150%
    bgContrast = 50%

  // Global scaling for large and medium variants

  if #{options.widgetSize} == big
    scale = 1
  else
    scale = 0.6

  // Aesthetics: Color palette

  fColor1 = rgba(fColor,1.0)
  fColor05 = rgba(fColor,0.5)
  fColor02 = rgba(fColor,0.2)
  bgColor1 = rgba(bgColor,1.0)
  bgColor05 = rgba(bgColor,0.5)
  bgColor02 = rgba(bgColor,0.2)


  margin = 0

  // Positioning magic.

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


  // Misc styles

  *, *:before, *:after
    box-sizing border-box

  mainDimension = 180pt
  position absolute
  width auto
  min-width 150pt
  overflow hidden
  white-space nowrap
  font-family system, -apple-system
  font-size 8pt
  border none
  z-index 10

  .wrapper
    color fColor1
    display flex
    flex-direction row
    justify-content flex-start
    flex-wrap nowrap
    align-items center
    overflow hidden
    z-index 1

  .art
    width 32pt
    height @width
    background-image url(/Playbox.widget/lib/default.png)
    background-color fColor05
    background-size cover
    z-index 3

  .text
    margin 0 6pt
    z-index 4

  .progress
    width @width
    height 1pt
    background-color fColor1
    position absolute
    bottom 0
    left 0
    z-index 6

  .progresstrack
    width 100%
    height 1pt
    background-color fColor05
    position absolute
    bottom 0
    left 0
    z-index 5

  .wrapper, .album, .artist, .song
    overflow hidden
    text-overflow ellipsis

  .album, .artist, .song
    max-width mainDimension

  .song
    display inline
    font-weight 700
    padding-right 4pt

  .audioCodec
    padding 2pt
    text-transform uppercase
    border 0.5px solid fColor05
    font-size 6pt
    position relative
    top -8pt
    z-index 4

  .album
    color fColor05

  // Different styles for different widget sizes.

  if #{options.widgetSize} == big or #{options.widgetSize} == medium

    min-width 0

    .wrapper
      flex-direction column
      justify-content flex-start
      flex-wrap nowrap
      align-items center

    .art
      width mainDimension * scale
      height @width
      margin 0

    .text
      position absolute
      text-align center
      width mainDimension * scale
      bottom 0
      left 0
      margin 0
      color fColor1
      padding 4pt * scale
      -webkit-backdrop-filter blur(10px)
      line-height 8pt
    
    .song, .artist, .album
      display block
      padding 2pt 0

    .audioCodec
      position absolute
      top 4pt
      right 4pt
    
"""

options : options

render: () -> """
  <div class="wrapper">
    <div class="art"><!-- <div class="heart">&#9829;</div> --></div>
    <div class="progress"></div>
    <div class="progresstrack"></div>
    <div class="text">
      <div class="song"></div>
      <div class="artist"></div>
      <div class="album"></div>
    </div>
    <div class="audioCodec"></div>
  </div>
  """

afterRender: (domEl) ->
  div = $(domEl)

  meta = div.find('.text')

  if @options.verticalPosition is 'center'
    div.css('top', (screen.height - div.height())/2)
  if @options.horizontalPosition is 'center'
    div.css('left', (screen.width - div.width())/2)

  # if @options.widgetSize isnt 'smol'
  #   meta.delay(3000).fadeOut(500)

# Update the rendered output.
update: (output, domEl) ->

  # Get our main DIV.
  div = $(domEl)
  values = output.slice(0,-1).split(" @ ")

  if values[0] is 'NA'
    div.fadeOut(500)
  else
    div.fadeIn(500)
    div.find('.artist').html(values[0])
    div.find('.song').html(values[1])
    div.find('.album').html(values[2])
    tDuration = values[3]
    tPosition = values[4]
    tArtwork = values[5]
    isLoved = values[6]
    audioCodec = values[7]

    # Progressbar
    tWidth = div.width()
    tCurrent = (tPosition / tDuration) * tWidth
    div.find('.progress').css width: tCurrent

    if audioCodec isnt 'NA'
      div.find('.audioCodec').html(audioCodec)
      if @options.widgetSize is 'smol'
        div.find('.audioCodec').css display: 'inline-block'
      else
        div.find('.audioCodec').css display: 'inline-block'

    # currArt = "/" + div.find('.art').css('background-image').split('/').slice(-3).join().replace(/\,/g, '/').slice(0,-1)
    # if currArt isnt tArtwork and tArtwork isnt 'NA'
    # artwork = div.find('.art')
    div.find('.art').css('background-image', 'url('+tArtwork+')')

    # else if tArtwork is 'NA'
    #   artwork = div.find('.art')
    #   artwork.css('background-image', 'url(/Playbox.widget/lib/default.png)')
      
    # div.css('max-width', screen.width)
