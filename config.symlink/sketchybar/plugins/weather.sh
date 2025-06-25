#!/usr/bin/env bash

# Load global styles, colors and icons
source "$CONFIG_DIR/globalstyles.sh"

WEATHER_ICONS_DAY=(
  [1000]= # Sunny/113
  [1003]= # Partly cloudy/116
  [1006]= # Cloudy/119
  [1009]= # Overcast/122
  [1030]= # Mist/143
  [1063]= # Patchy rain possible/176
  [1066]= # Patchy snow possible/179
  [1069]= # Patchy sleet possible/182
  [1072]= # Patchy freezing drizzle possible/185
  [1087]= # Thundery outbreaks possible/200
  [1114]= # Blowing snow/227
  [1117]= # Blizzard/230
  [1135]= # Fog/248
  [1147]= # Freezing fog/260
  [1150]= # Patchy light drizzle/263
  [1153]= # Light drizzle/266
  [1168]= # Freezing drizzle/281
  [1171]= # Heavy freezing drizzle/284
  [1180]= # Patchy light rain/293
  [1183]= # Light rain/296
  [1186]= # Moderate rain at times/299
  [1189]= # Moderate rain/302
  [1192]= # Heavy rain at times/305
  [1195]= # Heavy rain/308
  [1198]= # Light freezing rain/311
  [1201]= # Moderate or heavy freezing rain/314
  [1204]= # Light sleet/317
  [1207]= # Moderate or heavy sleet/320
  [1210]= # Patchy light snow/323
  [1213]= # Light snow/326
  [1216]= # Patchy moderate snow/329
  [1219]= # Moderate snow/332
  [1222]= # Patchy heavy snow/335
  [1225]= # Heavy snow/338
  [1237]= # Ice pellets/350
  [1240]= # Light rain shower/353
  [1243]= # Moderate or heavy rain shower/356
  [1246]= # Torrential rain shower/359
  [1249]= # Light sleet showers/362
  [1252]= # Moderate or heavy sleet showers/365
  [1255]= # Light snow showers/368
  [1258]= # Moderate or heavy snow showers/371
  [1261]= # Light showers of ice pellets/374
  [1264]= # Moderate or heavy showers of ice pellets/377
  [1273]= # Patchy light rain with thunder/386
  [1276]= # Moderate or heavy rain with thunder/389
  [1279]= # Patchy light snow with thunder/392
  [1282]= # Moderate or heavy snow with thunder/395
)

WEATHER_ICONS_NIGHT=(
  [1000]= # Clear/113
  [1003]= # Partly cloudy/116
  [1006]= # Cloudy/119
  [1009]= # Overcast/122
  [1030]= # Mist/143
  [1063]= # Patchy rain possible/176
  [1066]= # Patchy snow possible/179
  [1069]= # Patchy sleet possible/182
  [1072]= # Patchy freezing drizzle possible/185
  [1087]= # Thundery outbreaks possible/200
  [1114]= # Blowing snow/227
  [1117]= # Blizzard/230
  [1135]= # Fog/248
  [1147]= # Freezing fog/260
  [1150]= # Patchy light drizzle/263
  [1153]= # Light drizzle/266
  [1168]= # Freezing drizzle/281
  [1171]= # Heavy freezing drizzle/284
  [1180]= # Patchy light rain/293
  [1183]= # Light rain/296
  [1186]= # Moderate rain at times/299
  [1189]= # Moderate rain/302
  [1192]= # Heavy rain at times/305
  [1195]= # Heavy rain/308
  [1198]= # Light freezing rain/311
  [1201]= # Moderate or heavy freezing rain/314
  [1204]= # Light sleet/317
  [1207]= # Moderate or heavy sleet/320
  [1210]= # Patchy light snow/323
  [1213]= # Light snow/326
  [1216]= # Patchy moderate snow/329
  [1219]= # Moderate snow/332
  [1222]= # Patchy heavy snow/335
  [1225]= # Heavy snow/338
  [1237]= # Ice pellets/350
  [1240]= # Light rain shower/353
  [1243]= # Moderate or heavy rain shower/356
  [1246]= # Torrential rain shower/359
  [1249]= # Light sleet showers/362
  [1252]= # Moderate or heavy sleet showers/365
  [1255]= # Light snow showers/368
  [1258]= # Moderate or heavy snow showers/371
  [1261]= # Light showers of ice pellets/374
  [1264]= # Moderate or heavy showers of ice pellets/377
  [1273]= # Patchy light rain with thunder/386
  [1276]= # Moderate or heavy rain with thunder/389
  [1279]= # Patchy light snow with thunder/392
  [1282]= # Moderate or heavy snow with thunder/395
)

render_items() {
  DRAWING=$([ "$(cat /tmp/sketchybar_sender)" == "focus_on" ] && echo "off" || echo "on")

  if [ "$TEMP" = "" ]; then
    args=(--set $NAME drawing=$DRAWING icon="􀌏" label.drawing=off click_script="sketchybar --update")
  else
    args=(--set $NAME drawing=$DRAWING icon="$ICON" icon.color=$AQI_COLOR icon.font="Hack Nerd Font:Bold:14.0" label="${TEMP}°" label.drawing=on click_script="sketchybar --set weather popup.drawing=toggle")
  fi

  if [[ $AQI_NUMBER -gt 100 ]]; then
    args+=(--set aqi background.color=$AQI_COLOR label=$AQI_NUMBER drawing=$DRAWING)
  else
    args+=(--set aqi drawing=off)
  fi

  sketchybar "${args[@]}" >/dev/null
}

render_popup() {
  if [ "$TEMP" != "" ]; then
    args=(--set weather.location label="$LOCATION" icon=""
      --set weather.condition label="$CONDITION_TEXT" icon="$ICON"
      --set weather.aqi label="$AQI_NUMBER ($AQI_DESCRIPTION)" icon="" icon.color="$AQI_COLOR" label.color="$AQI_COLOR" click_script="sketchybar --set aqi background.color=$AQI_COLOR label=$AQI_NUMBER drawing=toggle"
      --set weather.precipitation label="$PRECIPITATION mm" icon="󰖌"
      --set weather.wind label="$WIND km/h $WIND_DIRECTION" icon=""
      --set weather.humidity label="$HUMIDITY%" icon="󰞍"
      --set weather.update label="$LAST_UPDATED minutes ago" icon="$ICON_REFRESH" click_script="sketchybar --update"
      --set weather.openapp label="More Information…" icon="" click_script="open -a /System/Applications/Weather.app; sketchybar --set weather popup.drawing=off")
  else
    args=(--set '/weather\..*/' drawing=off)
  fi

  sketchybar "${args[@]}" >/dev/null
}

update() {
  # API key from https://www.weatherapi.com/my/
  HOME="/Users/pe8er"
  WEATHER_API_KEY="$(cat $HOME/.dotfiles/secrets/weather)"
  AQI_API_KEY="$(cat $HOME/.dotfiles/secrets/aqi)"
  CITY="Wroclaw, Poland"
  CITY_NAME=${CITY%%,*}
  CITY=$(echo -n "$CITY" | perl -MURI::Escape -ne 'print uri_escape($_)')

  # get city from IP, sometimes pretty inaccurate
  # CITY="$(curl -s -m 5 ipinfo.io/loc)"

  if [ "$CITY" != "" ]; then
    WEATHER_DATA=$(curl -s -m 5 "http://api.weatherapi.com/v1/current.json?key=${WEATHER_API_KEY}&q=${CITY}")
    TEMP=$(echo $WEATHER_DATA | jq -r '.current.temp_c | floor')
    LOCATION=$(echo $WEATHER_DATA | jq -r '.location.name' && echo ', ' && echo $WEATHER_DATA | jq -r '.location.country')
    CONDITION=$(echo $WEATHER_DATA | jq -r '.current.condition.code')
    CONDITION_TEXT=$(echo $WEATHER_DATA | jq -r '.current.condition.text')
    PRECIPITATION=$(echo $WEATHER_DATA | jq -r '.current.precip_mm')
    HUMIDITY=$(echo $WEATHER_DATA | jq -r '.current.humidity')
    WIND=$(echo $WEATHER_DATA | jq -r '.current.wind_kph')
    WIND_DIRECTION=$(echo $WEATHER_DATA | jq -r '.current.wind_dir')
    IS_DAY=$(echo $WEATHER_DATA | jq -r '.current.is_day')
    LAST_UPDATED_EPOCH=$(echo $WEATHER_DATA | jq -r '.current.last_updated_epoch')
    AQI_DATA=$(curl -s -m 5 "https://api.waqi.info/feed/${CITY_NAME}/?token=${AQI_API_KEY}")
    AQI_NUMBER=$(echo $AQI_DATA | jq -r '.data.aqi | floor')

    CURRENT_EPOCH=$(date +%s)
    DIFFERENCE_SECONDS=$((CURRENT_EPOCH - LAST_UPDATED_EPOCH))
    LAST_UPDATED=$((DIFFERENCE_SECONDS / 60))

    case "$AQI_NUMBER" in
    [0-9] | [1-4][0-9] | 50)
      AQI_DESCRIPTION="Good"
      AQI_COLOR=$(getcolor green)
      ;;
    [5-9][0-9] | 100)
      AQI_DESCRIPTION="Moderate"
      AQI_COLOR=$(getcolor yellow)
      ;;
    1[0-4][0-9] | 150)
      AQI_DESCRIPTION="Unhealthy for Sensitive Groups"
      AQI_COLOR=$(getcolor orange)
      ;;
    1[5-9][0-9] | 200)
      AQI_DESCRIPTION="Unhealthy"
      AQI_COLOR=$(getcolor red)
      ;;
    2[0-9][0-9] | 300)
      AQI_DESCRIPTION="Very Unhealthy"
      AQI_COLOR=$(getcolor purple)
      ;;
    3[0-9][0-9] | 500)
      AQI_DESCRIPTION="Hazardous"
      AQI_COLOR=$(getcolor maroon)
      ;;
    *)
      AQI_DESCRIPTION="Unknown"
      AQI_COLOR=$HIGHLIGHT
      ;;
    esac

    [ "$IS_DAY" = "1" ] && ICON=${WEATHER_ICONS_DAY[$CONDITION]} || ICON=${WEATHER_ICONS_NIGHT[$CONDITION]}
    args=()

  fi
  render_items
  render_popup
  
}

popup() {
  sketchybar --set weather popup.drawing="$1"
}

case "$SENDER" in
"routine" | "forced" | "wifi_change" | "system_woke")
  update
  ;;
"mouse.clicked")
echo $SENDER $INFO
  ;;
esac
