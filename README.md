# Bbq (Шашлыки)
Web-application for organization of meetings with friends in different places. Application gives you opportunity to create events, look over them, subscribe to events of other users, upload photos to events. Also there is possibility to put the mark on the map (e.g. rendezvous point). There is mail sending service to users in order of new photos, comments adding to event on which user is subscribed. There is possibility to create private event which could be accessed only by PIN. User could log in using standard registartion process or via GitHub or VK profile.

# Try application
http://bbq.dack9.ru

# Screenshot
![Application screenshot](https://github.com/dmentry/bbq_my/blob/master/bbq_screenshot.jpg)

# System
Ruby 2.7.0

Rails 6.0.3

# Installation
```git clone git@github.com:dmentry/bbq.git```

## Before run
```bundle && bundle exec rake db:migrate```

```yarn```

### Run locally server
```bundle exec rails s```

### Open in browser

http://127.0.0.1:3000
