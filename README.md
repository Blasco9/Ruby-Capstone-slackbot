# Project Name

> This is my Ruby capstone project from the Microverse curriculum

This project consists of a bot created in Ruby that connects to the Slack API and The Movie Database API to give recommendations of movies and shows to watch

## Built With

- Ruby
- slack-ruby-bot
- celluloid-io

## Getting Started

To get a local copy up and running follow these simple example steps.

### Prerequisites

You will need to:
- Create a Slack workspace [here](https://slack.com/create#email)
- Have a Slack API Token. You can get one by creating an app [here](http://slack.com/services/new/bot)

To complete the installations you should have installed:
- Ruby
- Bundler

### Install

Download or clone the project

Then to install all the dependencies run

bundle install 

### Usage

To start using the bot you need to export your slack api token
export SLACK_API_TOKEN=<your token>

Once you have done that you can run it by typing
bundle exec ruby public/slack_bot.rb

After the bot is runing you can invite it to your channel

https://media.giphy.com/media/cjKZOcp8tPWznMip9Z/giphy.gif

### Commands

[help](./Animated GIF-1.gif)

[recommend me a movie and show](./GIF2.gif)

[recommend for genre](./GIF3.gif)

## Authors

👤 **Julian Blasco**

- Github: [@githubhandle](https://github.com/Blasco9)
- Linkedin: [linkedin](https://www.linkedin.com/in/julian-augusto-blasco-1656a0153/)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [issues page](issues/).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

This project was possible thanks to The Movie Database API and the creator of the Slack Ruby Bot gem

## 📝 License

This project is [MIT](lic.url) licensed.
