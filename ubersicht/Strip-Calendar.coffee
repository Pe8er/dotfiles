command:                  "echo 'Lauching StripCalendar...'"

settings = {

  # The locale in which to display day and month names
  locale:               "en-GB"

  # Orientation, either horizontal or vertical
  layout:               "horizontal"

  # Sunday & Saturday
  offdayIndices:        [0, 6]

  # Don't use a nine day fortnight
  nineDayFortnightStartDay: null
  #nineDayFortnightStartDay: new Date(2017,4,12) # First day off in a nine day fortnight

  color:                {
    white01:            "rgba(#fff, 0.1)"
    white03:            "rgba(#fff, 0.3)"
    white05:            "rgba(#fff, 0.5)"
    white1:             "rgba(#fff, 1)"
    black01:            "rgba(#111, 0.1)"
    yellow1:            "rgba(#fc3, 1)"
    yellow05:           "rgba(#fc3, 0.5)"
  }
  blurProperties:       "blur(16px) brightness(110%) contrast(110%) saturate(110%)"
}

refreshFrequency: 50
displayedDate: null

render: (output) -> """<div class="calendar #{settings.layout}">
    <table>
    <tbody>
    </tbody>
    </table>
    </div>
    """

style: """
  #{if settings.layout == "horizontal" then "bottom" else "top"}: 72px
  if #{settings.layout} == horizontal
    left 50%
    transform translateX(-50%)

  .debug
    background: rgba(green, 1)

  .calendar
    font-family system, -apple-system, 'Helvetica Neue'
    font-size 5pt
    font-weight 200
    color #{settings.color.white1}
    text-transform uppercase

  table
    border-collapse separate
    table-layout fixed
    border-spacing 0

  th, td
    text-align center

  .calendar.horizontal th, .calendar.horizontal td
    min-width: 22pt

  .calendar.horizontal th
    padding 8px 0
    // border-radius: 0 0 8px 8px
    border-top: 1px solid #{settings.color.white05}

  .calendar.horizontal th.offday
    border-top: 1px solid #{settings.color.white03}

  .calendar.horizontal th.offday.today, .calendar.horizontal td.offday.today
    border-top: 1px solid #{settings.color.white1}
    color #{settings.color.white1}

  .calendar.horizontal td.offday.today
    border-bottom none
    border-top none

  .calendar td
    padding 8px 0
    // border-radius 8px 8px 0 0
    font-size 7pt

  .today
    //-webkit-backdrop-filter #{settings.blurProperties}
    background-color #{settings.color.white05}
    //border solid 0.5pt #{settings.color.white1}
    font-weight 900
    //background linear-gradient(180deg, rgba(#{settings.color.white01}) 0%, rgba(#{settings.color.white03}) 100%)

  .offday
    color: #{settings.color.white05}
"""

converticalMilliSecondsToHours: (value) ->
  return Math.floor(value / ( 24 * 60 * 60 * 1000 ))

toMilliSeconds: (value) ->
  return value * ( 24 * 60 * 60 * 1000 )

toordinal: (date) ->
  zeroDate = new Date('0000-12-31')
  zeroDays = Math.abs(@converticalMilliSecondsToHours(zeroDate.getTime()))
  return zeroDays + @converticalMilliSecondsToHours(date.getTime())

getLocaleName: (d, locale, type, length) ->
  return d.toLocaleDateString(locale, { "#{type}": length })

getLocalizedDayNames: () ->
  dates = (new Date(2017, 0, day) for day in [1...8])
  return (@getLocaleName(d, settings.locale, "weekday", "short") for d in dates)

getLocalizedMonthNames: () ->
  dates = (new Date(2017, month, 1) for month in [0...12])
  return (@getLocaleName(d, settings.locale, "month", "long") for d in dates)

getClassName: (y, m, d, w, today) ->
  theDate = new Date(y, m, d)

  isToday = (d == today.getDate())

  if settings.nineDayFortnightStartDay isnt null
    dateDiff = @toordinal(theDate) - @toordinal(settings.nineDayFortnightStartDay)
    isFridayOff = ((dateDiff % 14) == 0)
  else
    isFridayOff = false

  isOffDay = (settings.offdayIndices.indexOf(w) isnt -1) or isFridayOff

  if isToday or isOffDay
    classNames = []
    if isToday
      classNames.push "today"
    if isOffDay
      classNames.push "offday"
  else
    classNames = ["ordinary"]

  return classNames.join(" ")

update: (output, domEl) ->
  date = new Date()
  y = date.getFullYear()
  m = date.getMonth()
  today = date.getDate()

  # DON'T MANIPULATE DOM IF NOT NEEDED
  newDate = [today, m, y].join("/")
  if(displayedDate != null && displayedDate == newDate)
    return
  else
    displayedDate = newDate

  firstOfMonth = new Date(y, m, 1)
  firstWeekDay = firstOfMonth.getDay()
  lastDay = new Date(y, m + 1, 0).getDate()

  dayNames = @getLocalizedDayNames()
  monthNames = @getLocalizedMonthNames()

  weekdays = []
  midlines = []
  dates = []

  days = [1..lastDay]
  daysOfWeek = (((dayOfMonth + firstWeekDay - 1) % 7) for dayOfMonth in days)

  if settings.layout == "horizontal"
    for dayOfMonth in [1..lastDay]
      dayOfWeek = ((dayOfMonth + firstWeekDay - 1) % 7)
      className = @getClassName(y, m, dayOfMonth, dayOfWeek, date)
      weekdays.push "<th class=\"#{className}\">#{dayNames[dayOfWeek]}</th>"

      dayOfMonth = dayOfMonth.toLocaleString(settings.locale)
      dates.push "<td class=\"#{className}\">#{dayOfMonth}</td>"

    tbody_html = """
      <tr class="date">#{dates.join("")}</tr>
      <tr class="midline">#{midlines.join("")}</tr>
      <tr class="weekday">#{weekdays.join("")}</tr>
    """
  else
    tbody_html = ""
    c = days.map((e, i) -> [e, daysOfWeek[i]])
    for item in c
      dayOfMonth = item[0]
      dayOfWeek = item[1]
      className = @getClassName(y, m, dayOfMonth, dayOfWeek, date)
      tbody_html += """<tr>
        <th class=\"#{className}\">#{dayOfMonth}</th>
        <td class=\"#{className}\">#{dayNames[dayOfWeek]}</td>
      </tr>"""

  $(domEl).find("tbody").html(tbody_html)

  year = y.toLocaleString(settings.locale, { useGrouping: false })
  $(domEl).find("caption .month").html("#{monthNames[m]}")
  $(domEl).find("caption .year").html("#{year}")
  return
