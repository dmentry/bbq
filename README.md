# Bbq (Шашлыки)
Web-application for organization of meetings with friends in different places. Application gives you opportunity to create events, look over them, subscribe to events of other users, upload photos to events. Also there is possibility to put the mark on the map (e.g. rendezvous point). There is mail sending service to users in order of new photos, comments adding to event on which user is subscribed. There is possibility to create private event which could be accessed only by PIN. User could log in using standard registartion process or via GitHub or VK profile.

## Live Demo
http://bbq.dack9.ru

## Screenshot
![Application screenshot](https://github.com/dmentry/bbq_my/blob/master/bbq_screenshot.jpg)

## Main requirements
* Ruby 2.7.0

* Rails 6.0.3

## Clone

```
git clone git@github.com:dmentry/bbq.git
```

## Before run
Put tokens from next services to `config/credentials.yml.enc` with

```
rails credentials:edit
```

Structure of `credentials.yml.enc`:

```
development:
  aws:
    S3_ACCESS_KEY:  ...
    S3_SECRET_KEY:  ...
    S3_BUCKET_NAME: ...
  yandex_maps:
    api_key: ...
  mailjet:
    mailjet_username: ...
    mailjet_password: ...
    mailjet_sender:   ...
  github:
    github_client_id:     ...
    github_client_secret: ...
  vkontakte:
    vkontakte_client_id:     ...
    vkontakte_client_secret: ...
    
production:
  aws:
    S3_ACCESS_KEY:  ...
    S3_SECRET_KEY:  ...
    S3_BUCKET_NAME: ...
  yandex_maps:
    api_key: ...
  mailjet:
    mailjet_username: ...
    mailjet_password: ...
    mailjet_sender:   ...
  pg:
    user:     ...
    password: ...
    database: ...
  redis:
    password: ...
  github:
    github_client_id:     ...
    github_client_secret: ...
  vkontakte:
    vkontakte_client_id:     ...
    vkontakte_client_secret: ...
```

### Install and migrate db

```
bundle install
```

```
bundle exec rake db:migrate
```

```
yarn
```

### Start server
To start rails server:

```
bundle exec rails s
```

### Open in browser

http://127.0.0.1:3000
