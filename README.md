# README

## The task: 
https://docs.google.com/document/d/17wv7TI5TJiOj6NRAOdkMutHJ_Lthr17msjm-AqT-yRw/edit#heading=h.cagu4jf61l7f

## Setup 
I assume you've already got PG and REDIS servers on your local machine, so provide the creds!
```bash
    export POSTGRES_PASSWORD=password
    export DB_USER=postgres
    export DB_HOST=localhost
    export REDIS_URL=redis://localhost:6379/
```

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