# README

## The task: 
https://docs.google.com/document/d/17wv7TI5TJiOj6NRAOdkMutHJ_Lthr17msjm-AqT-yRw/edit#heading=h.cagu4jf61l7f

## Setup 
I assume you already have PG and REDIS servers on your local machine. Please create a .env file in the root directory 
and populate it with the credentials.

then: 
```bash
    rake db:create
    rake db:migrate
    rake db:seed
```

and eventually: 
```bash
    rails s
```