#!/bin/bash

USERNAME=${1:-$USER}
dockervolpath=$(docker volume inspect weeslackdocker_weeslack -f '{{ .Mountpoint }}')
logspath="${dockervolpath}/logs"

function notifysenddmlogline {
  channel=$(filename $1 | cut -d'.' -f 3-)
  tail -n 0 -f $1 | grep --line-buffered '.*' |
    while IFS= read -r LINE0
    do
      notify-send $channel "$(echo $LINE0 | cut -d' ' -f3-)"
    done
}

function notifysendpubliclogline {
  channel=$(filename $1 | cut -d'.' -f 3-)
  tail -n 0 -f $1 | grep --line-buffered '.*' |
    while IFS= read -r LINE0
    do
      if echo $LINE0 | grep -q $2; then
        notify-send $channel "$(echo $LINE0 | cut -d' ' -f3-)"
      fi
    done
}

function searchdms {
  for dm in $(find "$logspath" -maxdepth 1 -type f | grep -P '.*python\.slack\..*\.((?!#).)*\.weechatlog'); do
    if [[ "$1" == "stop" ]]; then
      kill -15 $(ps ax | grep tail | grep "$dm" | awk '{print $1}') 2>/dev/null
    else
     notifysenddmlogline $dm &
    fi
  done
}

function searchpublics {
  for publicat in $(find "$logspath" -maxdepth 1 -type f | grep -P '.*python\.slack\..*\.\#.*\.weechatlog'); do
    if [[ "$1" == "stop" ]]; then
      kill -15 $(ps ax | grep tail | grep "$publicat" | awk '{print $1}') 2>/dev/nul
    else
      notifysendpubliclogline $publicat $USERNAME &
    fi
  done
}

function restartdms {
  searchdms stop
  searchdms $USERNAME
}

function restartpublics {
  searchpublics stop
  searchpublics $USERNAME
}

searchdms
searchpublics

if [[ $USERNAME == "stop" ]]; then
  searchdms stop
  searchpublics stop
else
  inotifywait -m "$logspath" -e create |
    while read dir action file; do
      restartdms &
      restartpublics &
    done
fi
