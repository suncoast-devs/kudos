# Kudos

Setup application.

```
./bin/setup
```

Run development server, using `foreman` or [`overmind`](https://evilmartians.com/chronicles/introducing-overmind-and-hivemind)

```
overmind start
```

## Models

### Organization

- name
- emoji
- daily_budget

### Authorization

- platform (e.g. Slack)
- data (raw auth data)
- access_token
- refresh_token
- expires_at

### Event

- platform (e.g. Slack)
- status (e.g. pending, processing, complete)
- data (raw params)
