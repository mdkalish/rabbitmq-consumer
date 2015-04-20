# [RabbitMQ workshop](https://www.rabbitmq.com)
### [My Trello Board](https://trello.com/b/JLrjbdHg/workshop-rabbitmq-maciej-kalisz)
#### [Publisher App](https://github.com/mdkalish/rabbitmq-publisher)
#### [Consumer App](https://github.com/mdkalish/rabbitmq-consumer)
  
  
---
  
### Migrations & tests  
  
In order for the tests and migrations to work properly, you must call them with `QUEUE_ID=1` argument.
You can do this in several ways, e.g.:  
  - by calling relevant commands with explicit variable, e.g. `QUEUE_ID=1 rake db:setup`  
  - by adding `export QUEUE_ID=1` to your shell configuration file  
  - with `figaro` gem  
  
