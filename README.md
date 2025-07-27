# README

## API
To post an alert, use:

```bash
curl -X POST http://localhost:3000/api/alerts \
  -H "Content-Type: application/json" \
  -H "X-Api-Key: alert_appxxxxxxxxxxxxxxxxxxxxxxxx" \
  -d '{"message": "Test alert from curl"}'
```
