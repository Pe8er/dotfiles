#!/bin/bash
curl -X POST --data-urlencode "payload={\"username\": \"Sonarr\", \"icon_emoji\": \":ghost:\", \"text\": \"$sonarr_eventtype: $sonarr_series_title S$sonarr_episodefile_seasonnumber E$sonarr_episodefile_episodenumbers ($sonarr_episodefile_quality)\"}" $1

