##### Prerequisites

The setups steps expect following tools installed on the system.

- Github
- Redis server
- Postgresql
- Ruby 2.6.3
- Rails 6.0.2
- Chromedriver (for test)

##### 1. Check out the repository

```bash
git clone git@github.com:abuhtoyarov/currency_informer.git
```

##### 2. Setup

Dependency installation application preparation

```bash
./bin/setup
```

##### 4. Start server and dependencies

- http://localhost:3000  (exchange rate information page)
- http://localhost:3000/admin (page for setting forced rate)

```bash
bundle exec foreman start
```

##### 5. Rspec

Running tests

```bash
bundle exec rspec
```

