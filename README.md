# BDD File BE

## Setup
- copy env sample `cp .env.sample .env` then correct the require field
- go into `database.yml` and correct your database config
- run `rails db:create` to init database
- run `rails db:migrate` to setup tables
- then run `rails db:seed` to generate some seed data (`orgnisation` and `member`)
- finally, run `rails s` to start the server

## API
- on default, the server address is `localhost:3000`
- supported api:
    - get `localhost:3000/files` list all files from database
    - get `localhost:3000/files/${id}` get one file
    - post `localhost:3000/files` update a new file to openai platform and save to database
    - delete `localhost:3000/files/${id}` delete file both database and openai platform

## Example
```bash
curl --location 'localhost:3000/files' \
--header 'Content-Type: application/json' \
--data '{
    "member_id": "678990c0-4397-4b69-84a8-a21ff11dd3b8",
    "purpose": "assistants",
    "file": "/path/to/sample.pdf"
}'
```

## Run test
WIP
