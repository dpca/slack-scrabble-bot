# scrabble-bot

A bot for tallying scrabble scores in slack channels. Scrabble emoji must be in
the form :scrabble_a:, :scrabble_b:, etc.

## Run locally

Uses [dotenv](https://github.com/motdotla/dotenv) for development
configuration. Set the following in `.env`:

* SLACK_TOKEN - see below
* SLACK_CHANNELS - slack channel(s) to join, comma separated

You can request a token for testing purposes from
https://api.slack.com/docs/oauth-test-tokens but should use a bot token from
https://my.slack.com/services/new/bot for a real deployment. Read more about
bot users here: https://api.slack.com/bot-users.

```
yarn build
node dist/app.js
```

## Run with docker

```
docker-compose up
```
